// Binary Tree Example

public with sharing class binaryTreeExample {

    // Create a Node Class
    public class Node{
        Object data;
        Node left;
        Node right;

        public Node(Object data){
            this.data = data;
            this.left = null;
            this.right = null;
        }
    }

    // Root Node of the Binary Tree
    Node root;  

    // Method to insert data in binary tree
    private void insertData(Object data){

        // If root is null, create a new node and return
        if(root == null){
            root = new Node(data);
            return;
        }

        // Initializing a queue of nodes
        List<Node> nodesQueque = new List<Node>();

        // Adding root node to queue
        nodesQueque.add(root);
        
        // Looping while queue is not empty
        while(nodesQueque != null){

            // Getting the current node and removing if from the queue
            Node current = nodesQueque.get(0);
            nodesQueque.remove(0);

            // If left child of the current node is not null add it to the queue
            if(current.left != null){
                nodesQueque.add(current.left);
            }
            else{
                current.left = new Node(data);
                return;
            }

            // If right child of the current node is not null add it to the queue
            if(current.right != null){
                nodesQueque.add(current.right);
            }
            else{
                current.right = new Node(data);
                return;
            }
        }
    }

    // Method to receive the data and create a binary tree
    public void createBinaryTree(List<Object> elements){

        // Inserting elements in binary tree
        for(Object element : elements){
            insertData(element);
        }
    }

    // Method to print Binary tree level by level
    public void levelOrderPrint(){

        if(root != null){
            String result = '\n';     

            // Initializing a queue
            List<Node> nodesQueue = new List<Node>();
            nodesQueue.add(root);

            // Looping while queue is not empty
            while (! nodesQueue.isEmpty()) {
                
                // Getting nodes at current level
                Integer nodesAtCurrentLevel = nodesQueue.size();

                while (nodesAtCurrentLevel > 0) {
                    
                    // Getting the current node and removing it from the queue
                    Node current = nodesQueue.get(0);
                    nodesQueue.remove(0);

                    // Adding current node data to result
                    result += current.data + ' ';

                    // If left child of the current node is not null add it to the queue
                    if(current.left != null){
                        nodesQueue.add(current.left);
                    }

                    // If right child of the current node is not null add it to the queue
                    if(current.right != null){
                        nodesQueue.add(current.right);
                    }

                    // Decrementing nodes at current level by 1
                    nodesAtCurrentLevel --;
                }

                // Adding a new line to the result for next level
                result += '\n';
            }

            // Displaying the result
            System.debug(result);
        }
        else{
            System.debug('Tree Not Found');
        }
    }
}
















/*

public with sharing class binaryTreeExample {

    // Creating an Wrapper Class
    public class StudentInfo{
        public String name;
        public Integer age;
        public StudentInfo stdInfo;

        public StudentInfo(String name, Integer age){
            this.name = name;
            this.age = age;
            this.stdInfo = null;

        }
    }
}
binaryTreeExample student = new binaryTreeExample();

binaryTreeExample.StudentInfo std1 = new binaryTreeExample.StudentInfo('Alice', 34);
binaryTreeExample.StudentInfo std2 = new binaryTreeExample.StudentInfo('Hay', 45);
binaryTreeExample.StudentInfo std3 = new binaryTreeExample.StudentInfo('Abhay', 65);

System.debug('std1 : ' + std1.name + ' : ' + std1.age + ' : ' + std1.stdInfo);
System.debug('std2 : ' + std2.name + ' : ' + std2.age + ' : ' + std2.stdInfo);
System.debug('std3 : ' + std3.name + ' : ' + std3.age + ' : ' + std3.stdInfo);

std1.stdInfo = std2;
std2.stdInfo = std3;
System.debug('std1 stdInfo : ' + std1.stdInfo);
System.debug('std2 stdInfo : ' + std2.stdInfo);


*/