require "rpstree/version"
require "sys/proctable"
require "tree"

include Sys

# This module contains functionality that allows you to display a process tree.
# A process tree is a pretty print of a process and all its child processes.
# This module uses sys/protable to gather information on processes and RubyTree
# to build the process tree(s).
module Rpstree

  # This class represents the concept of a process tree viewer.
  # 
  # Use it like this: 
  #   ptv = ProcTreeViewer.new(process_id)
  #   ptv.show_tree
  #--
  # TODO: Remove ctor and expose on show_tree.
  class ProcTreeViewer
    
    include Methadone::CLILogging
    
    def initialize(procid)
      @proc_id = procid ? procid.to_i : nil
    end
    
    # Displays the process tree.
    def show_tree
      all = ProcTable.ps
      if @proc_id
        # Show tree for a particular process.
        t = get_proc_tree(@proc_id, all)
        if t
          kluge = t.node_depth
          t.each { |n| puts "#{'  ' * (n.node_depth-kluge)}#{n.content} (#{n.name})" } if t
        end
      else
        # Show tree for each top-level processes.
        toplevel = get_top_level(all)
        toplevel.each do |t|
          t.each { |n| puts "#{'  ' * n.node_depth}#{n.content} (#{n.name})" }
        end
      end
    end

    private
    
    # Returns Tree::TreeNode containing all child processes for pid
    def get_proc_tree(pid, procs)
      pid_node = nil
      nodes = Hash.new
      
      procs.each do |p|
        node = Tree::TreeNode.new(p.pid.to_s, p.name)
        nodes[p.pid] = node
        
        pid_node = node if p.pid == pid
        
        # Find parent proc in list of processes.
        pproc = procs.select { |proc| (proc.pid == p.ppid) && (proc.pid != proc.ppid) }
        if pproc.length > 0
          # Found the parent process in list of processes.
          # Check if we have a tree node for the parent.
          pnode = nodes[p.ppid]
          if pnode
            # We have a parent tree node, so make node one of its children.
            pnode.add(node)
          end
        end
      end
      pid_node
    end
    
    # Builds an array containing all top-level processes. A top-level process
    # is any process without a parent process.
    #
    # procs is an array of ProcTableStruct objects.
    #
    # Returns an array of Tree::TreeNode objects.
    def get_top_level(procs)
      top = []
      nodes = Hash.new
      
      procs.each do |p|
        node = Tree::TreeNode.new(p.pid.to_s, p.name)
        nodes[p.pid] = node
        debug("pid=#{p.pid}, name=#{p.name}")
        
        # Find parent proc in list of processes.
        # TODO: Explain why we need (proc.pid != proc.ppid)
        pproc = procs.select { |proc| (proc.pid == p.ppid) && (proc.pid != proc.ppid) }
        if pproc.length > 0
          # Found the parent process in list of processes.
          # Check if we have a tree node for the parent.
          pnode = nodes[p.ppid]
          if pnode
            # We have a parent tree node, so make node one of its children.
            pnode.add(node)
          end
        else
          # Didn't find parent process in list of processes. Means that the process
          # is a top-level process.
          top << node
        end
      end
      
      top
    end
  end
end
