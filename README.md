PCGraph
=======

Objective-C implementation of a weighted directed graph and Dijkstra's algorithm for shortest path finding.

Get Started
===========

- [Browse PCGraph source code](https://github.com/pierredavidbelanger/PCGraph) on GitHub
- [Download PCGraph](https://github.com/pierredavidbelanger/PCGraph/archive/master.zip) and have a look at the testcases
- Check the complete public API [documentation](http://pcgraph.pjer.ca/)

Usage
=====

Here is all the code needed to reproduce using `PCGraph` the example on the Dijkstra's algorithm Wikipedia page (http://en.wikipedia.org/wiki/Dijkstra's_algorithm)
        
    PCGDirectedGraph *graph = [PCGDirectedGraph directedGraphWithCapacity:6];
    [graph addEdgesBetweenVertex:@1 andVertex:@2 withWeight:7];
    [graph addEdgesBetweenVertex:@1 andVertex:@3 withWeight:9];
    [graph addEdgesBetweenVertex:@1 andVertex:@6 withWeight:14];
    [graph addEdgesBetweenVertex:@2 andVertex:@3 withWeight:10];
    [graph addEdgesBetweenVertex:@2 andVertex:@4 withWeight:15];
    [graph addEdgesBetweenVertex:@3 andVertex:@4 withWeight:11];
    [graph addEdgesBetweenVertex:@3 andVertex:@6 withWeight:2];
    [graph addEdgesBetweenVertex:@5 andVertex:@4 withWeight:6];
    [graph addEdgesBetweenVertex:@5 andVertex:@6 withWeight:9];
    
    PCGPathFinder *pathFinder = [PCGPathFinderDijkstra pathFinder];
    PCGPath *path = [pathFinder findPathInGraph:graph fromVertex:@1 toVertex:@5];
    
    XCTAssertNotNil(path, @"path should not be nil");
    XCTAssertNotNil(path.vertices, @"path.vertices should not be nil");
    XCTAssertTrue(path.vertices.count == 4, @"path.vertices should contains a 4 steps path");
    XCTAssertEqualObjects(path.vertices, (@[@1, @3, @6, @5]), @"path.vertices should contains the solution [1, 3, 6, 5]");
    XCTAssertTrue(path.weight == 20, @"path.weight should be 20");

License
=======

`PCGraph` is available under the MIT license. See the LICENSE file for more info.

	//
	//  PCGraph
	//
	//  Created by Pierre-David Bélanger <pierredavidbelanger@gmail.com>
	//  Copyright (c) 2013 PjEr.ca. All rights reserved.
	//
	//  Permission is hereby granted, free of charge, to any person obtaining a copy
	//  of this software and associated documentation files (the "Software"), to
	//  deal in the Software without restriction, including without limitation the
	//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
	//  sell copies of the Software, and to permit persons to whom the Software is
	//  furnished to do so, subject to the following conditions:
	//
	//  The above copyright notice and this permission notice shall be included in
	//  all copies or substantial portions of the Software.
	//
	//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
	//  DEALINGS IN THE SOFTWARE.
	//

