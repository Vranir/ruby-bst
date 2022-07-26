     
class Bst
  require "./mergeSort.rb"
  attr_accessor :root
  def initialize(arr)
    arr.uniq!
    mergeSort(arr)
    @root=self.BstFromList(arr)   
  end   

  class Node
    attr_accessor :data,:left, :right  
    def initialize(data)
      @data=data
      @left=nil
      @right=nil
    end
  end

  def BstFromList(arr) 
    if arr.length!=0
      mid=(arr.length)/2
      
      node=Node.new(arr[mid])
      
      node.left=BstFromList(arr[...mid])
      node.right=BstFromList(arr[mid+1..])      
      return node    
    end      
  end

  def insert(data, root=@root)
    if root==nil
      return Node.new(data)
    else
      #if root.data==data
      #  return nil
      if root.data<data
        root.right=insert(data,root.right)
      else
        root.left=insert(data, root.left)   
    
      end
    end
    return root
  end

  def minValNode(node) #helper traverse for #delete
    curr=node
    
    while curr.left != nil
      
      curr=curr.left
    end
    return curr
  end

  def delete(data, root=@root)
    if root==nil
      return root
    end   
    if data<root.data
      
      root.left=delete(data, root.left)
    elsif data>root.data
      
      root.right=delete(ddata, root.right)
    else
      if root.left==nil
        
        temp=root.right        
        root=nil
        return temp
      elsif root.right==nil        
        temp=root.left
        root=nil
        return temp
      else
        
        temp=self.minValNode(root.right)
        root.data=temp.data
        root.right=delete(temp.data, root.right)
      end 
    end
    return root
  end

  def find(curr=@root,data)    
    if curr==nil
      return false
    end
    if curr.data==data
      return curr
    elsif curr.data<data      
      return find(curr.right,data)
    else      
      return find(curr.left,data)
    end
    return false
  end

  
  
  def PreOrder (node=@root, arr=[], &block)
    if block_given?
      if node==nil
        return nil
      end
      yield node.data
      PreOrder(node.left,arr,&block)
      PreOrder(node.right,arr,&block)
    else
      if node==nil
        return arr
      end
      arr.push(node.data)
      PreOrder(node.left,&block)
      PreOrder(node.right,&block)
    end
  end
  
  def InOrder (node=@root,arr=[],&block)
    if block_given?
      if node==nil
        return nil
      end  
      InOrder(node.left,arr,&block)
      yield node.data
      InOrder(node.right,arr,&block)
    else
      if node==nil
        return arr
      end  
      InOrder(node.left,arr,&block)
      arr.push(node.data)
      InOrder(node.right,arr,&block)
    end
  end

  def PostOrder (node=@root,arr=[],&block)
    if block_given?
      if node==nil
        return nil
      end  
      PostOrder(node.left,arr,&block)    
      PostOrder(node.right,arr,&block)
      yield node.data
    else
      if node==nil
        return nil
      end  
      PostOrder(node.left,arr,&block)    
      PostOrder(node.right,arr,&block)
      arr.push(node.data)
    end
  end

  def levelTraverse(node=@root) #strange return nil at end if block passed
    arr=[]   
    if node==nil 
      return nil
    end
    queue=[]
    queue.append(node)    
    while queue.length>0
      if block_given?
        yield queue[0].data        
      else
        arr.push(queue[0].data)
      end
      curr=queue.shift      
      if curr.left != nil
        queue.push(curr.left)
      end
      if curr.right != nil
        queue.push(curr.right)
      end      
    end
    if !block_given?
      return arr
    end        
  end

  def height(node=@root)
    if node!=nil
      l=height(node.left)
      r=height(node.right)
      if l>r
        return l+1
      else
        return r+1
      end
    else
      return 0
    end   
  end

  def balanced?(node=@root)
    left=height(node.left)
    right=height(node.right)
    if (left-right).abs<=1
      return true
    else
      return false
    end
  end

  def rebalance
    arr=self.InOrder
    self.initialize(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  
  
end


   







#test
#sortedlst=[1,2,3,4,5,6,7,8,9]
#sortedlst=[1, 7, 23, 8, 9, 4, 3, 5, 67, 6345, 324]
sortedlst=[1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]


newtree=Bst.new(sortedlst)
p "tree:"
newtree.pretty_print()


p "insert test 56,51,11"
newtree.insert(56)
newtree.insert(51)
newtree.insert(11)
#newtree.insert(newtree.root,23)
newtree.pretty_print()

p "delete test 4"
newtree.delete(4)
newtree.pretty_print()

p "delete test 1"
newtree.delete(1)
newtree.pretty_print()

p "find test 56"
p newtree.find(56)
p "find test 3"
p newtree.find(3)
p "find test 543"
p newtree.find(543)

p "new preorder"
newtree.PreOrder{|node| p node}
p "new inorder"
newtree.InOrder{|node| p node}
p "new postorder"
newtree.PostOrder{|node| p node}
p "postorder mod (x+2)"
newtree.PostOrder{|node| p node+2}
p "inorder no block"
p newtree.InOrder

p "tree height"
p newtree.height

p "chck balance"
newtree.pretty_print()
p newtree.balanced?


p "insert values"
newtree.insert(2)
newtree.insert(1)
newtree.insert(6)
newtree.pretty_print()
p newtree.balanced?

newtree.insert(156)
newtree.insert(256)
newtree.insert(356)
newtree.insert(456)
newtree.pretty_print()
p newtree.balanced?

p "del 1"
newtree.delete(1)
newtree.pretty_print()
p newtree.balanced?

p "rebalance"
newtree.rebalance
newtree.pretty_print()

p "levelTraverse"
p newtree.levelTraverse()
p newtree.levelTraverse(){|elem| puts elem+2}
