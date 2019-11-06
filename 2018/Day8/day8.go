package main

import (
	"fmt"
	"strings"
	"utils"
	"strconv"
)

type node struct {
	numNodes, numMetadata int
	metadatas []int
	children []node
}

func (n *node) metadataSum() int {
	sum := 0
	for _, metadata := range n.metadatas {
		sum += metadata
	}

	for _, child := range n.children {
		sum += child.metadataSum()
	}

	return sum
}

func (n *node) nodeLength() int {
	length := 2 // header
	length += n.numMetadata
	for _, child := range n.children {
		length += child.nodeLength()
	}

	return length
}

func (n *node) nodeValue() int {
	value := 0

	for _, metadata := range n.metadatas {
		if n.numNodes == 0 {
			value += metadata
		} else {
			childIndex := metadata - 1
			if childIndex < n.numNodes {
				value += n.children[childIndex].nodeValue()
			}
		}
	}
	

	return value
}

func newNode() node {
	newNode := node{}
	newNode.numNodes = -1
	newNode.numMetadata = -1
	newNode.metadatas = []int{}
	newNode.children = []node{}
	return newNode
}

func main() {
	input := utils.ReadFileAsString("input.txt")
	splitInput := strings.Split(input, " ")

	header := make([]int,len(splitInput))

	for i, str := range splitInput {
		number, error := strconv.Atoi(str)
		utils.Check(error)
		header[i] = number
	}

	rootNode := buildNode(header)

	metadataSum := rootNode.metadataSum()

	fmt.Println("Metadata sum is", metadataSum)
	fmt.Println("Rootnode value is", rootNode.nodeValue())
}

func buildNode(header []int) node {
	newNode := newNode()
	newNode.numNodes = header[0]
	newNode.numMetadata = header[1]

	nextNodeStart := 2
	for i := 0; i < newNode.numNodes; i++ {
		childNode := buildNode(header[nextNodeStart:])
		newNode.children = append(newNode.children, childNode)
		nextNodeStart += childNode.nodeLength()
	}

	metadataStart := newNode.nodeLength() - newNode.numMetadata
	metadataEnd := metadataStart + newNode.numMetadata
	for _, metadata := range header[metadataStart:metadataEnd] {
		newNode.metadatas = append(newNode.metadatas, metadata)
	}

	return newNode
}