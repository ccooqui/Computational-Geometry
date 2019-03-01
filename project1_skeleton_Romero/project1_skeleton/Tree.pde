/*
class Node {
  int data;
  Node left, right;
  public Node(int _data){
    data = _data;
    left = right = null;
  }
}

class Tree {
    Node root;
    
    void storeNode(Node root, ArrayList<Node> nodes) {
      if (root == null) {
        return;
      }
      storeNode(root.left, nodes);
      nodes.add(root);
      storeNode(root.right,nodes);
    }
    
    Node buildTree(ArrayList<Node> nodes, int begin, int end) {
      if (begin > end){
        return null;
      }
      int mid = (begin + end)/2;
      Node node = nodes.get(mid);
      
      node.left = buildTree(nodes, begin, mid - 1);
      node.right = buildTree(nodes, mid + 1, end);
      return node;
    }
    
    Node treeBST(Node root) {
      ArrayList<Node> nodes = new ArrayList();
      storeNode(root, nodes);
      return buildTree(nodes, 0, n - 1);
    }
    
}*/
