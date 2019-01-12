require "byebug"
class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(new_parent)
        current_parent = @parent
        remove_self_from_parent if current_parent
        @parent = new_parent
        add_self_to_parent unless new_parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise ArgumentError.new("We don't have this kid") unless child?(child_node)
        child_node.parent = nil
    end

    def dfs(target)
        return self if value == target 
        return nil if children.length.zero?

        children.each do |child|
            children_return = child.dfs(target)
            return children_return if children_return
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.length.zero?
            current_node = queue.shift
            return current_node if current_node.value == target
            current_node.children.each { |child_node| queue << child_node }
        end
        nil
    end 

    
    

    private

    def remove_self_from_parent
        @parent.children.reject! { |node| node == self }
    end

    def add_self_to_parent
        @parent.children << self
    end

    def child?(possible_child)
        self.children.include?(possible_child)
    end
end
