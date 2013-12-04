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

#import <XCTest/XCTest.h>

#import "PCGraph.h"

@interface PCGraph_Tests : XCTestCase

@property (strong) PCGDirectedGraph *graph;

@property (strong) PCGPathFinder *pathFinder;

@end

@implementation PCGraph_Tests

- (void)setUp
{
    [super setUp];
    
    /*
                 (1)->(2)<->(3)->(4)
                 ^                |
                 |                |
                 +----------------+
     */
    self.graph = [PCGDirectedGraph directedGraph];
    [self.graph addEdgeFromVertex:@1 toVertex:@2];
    [self.graph addEdgesBetweenVertex:@2 andVertex:@3];
    [self.graph addEdgeFromVertex:@3 toVertex:@4];
    [self.graph addEdgeFromVertex:@4 toVertex:@1];
    
    self.pathFinder = [PCGPathFinderDijkstra pathFinder];
}

- (void)tearDown
{
    self.graph = nil;
    [super tearDown];
}

- (void)assert_shouldFindPathFromVertex:(PCGVertex)source toVertex:(PCGVertex)target
{
    PCGPath *path = [self.pathFinder findPathInGraph:self.graph fromVertex:source toVertex:target];
    XCTAssertNotNil(path, @"path should not be nil");
    XCTAssertTrue(path.vertices.count, @"should had found a path from %@ to %@", source, target);
}

- (void)assert_shouldNotFindPathFromVertex:(PCGVertex)source toVertex:(PCGVertex)target
{
    PCGPath *path = [self.pathFinder findPathInGraph:self.graph fromVertex:source toVertex:target];
    XCTAssertNotNil(path, @"path should not be nil");
    XCTAssertFalse(path.vertices.count, @"should not had found a path from %@ to %@", source, target);
}

- (void)test_removeVertex
{
    [self.graph removeVertex:@3];
    [self assert_shouldNotFindPathFromVertex:@2 toVertex:@3];
    [self assert_shouldNotFindPathFromVertex:@2 toVertex:@4];
    [self assert_shouldFindPathFromVertex:@1 toVertex:@2];
    [self assert_shouldFindPathFromVertex:@4 toVertex:@1];
}

- (void)test_removeEdgesBetweenVertex_andVertex
{
    [self.graph removeEdgesBetweenVertex:@2 andVertex:@3];
    [self assert_shouldNotFindPathFromVertex:@2 toVertex:@3];
    [self assert_shouldNotFindPathFromVertex:@1 toVertex:@4];
    [self assert_shouldFindPathFromVertex:@3 toVertex:@2];
}

- (void)test_removeEdgeFromVertex_toVertex
{
    [self.graph removeEdgeFromVertex:@2 toVertex:@3];
    [self assert_shouldNotFindPathFromVertex:@2 toVertex:@3];
    [self assert_shouldFindPathFromVertex:@3 toVertex:@2];
}

- (void)test_removeEdgesFromVertex
{
    [self.graph removeEdgesFromVertex:@3];
    [self assert_shouldNotFindPathFromVertex:@3 toVertex:@2];
    [self assert_shouldNotFindPathFromVertex:@3 toVertex:@4];
    [self assert_shouldFindPathFromVertex:@2 toVertex:@3];
}

- (void)test_removeEdgesToVertex
{
    [self.graph removeEdgesToVertex:@2];
    [self assert_shouldNotFindPathFromVertex:@1 toVertex:@2];
    [self assert_shouldNotFindPathFromVertex:@3 toVertex:@2];
    [self assert_shouldFindPathFromVertex:@2 toVertex:@3];
}

- (void)testFindPathToInvalidVertex
{
    [self assert_shouldNotFindPathFromVertex:@1 toVertex:@5];
}

- (void)testFindPathFromInvalidVertex
{
    [self assert_shouldNotFindPathFromVertex:@5 toVertex:@1];
}

- (void)testFindPathToNotConnectedVertex
{
    [self.graph addVertex:@5];
    [self assert_shouldNotFindPathFromVertex:@1 toVertex:@5];
}

- (void)testFindPathFromNotConnectedVertex
{
    [self.graph addVertex:@5];
    [self assert_shouldNotFindPathFromVertex:@5 toVertex:@1];
}

- (void)testFindPathToTerminalVertex
{
    [self.graph addEdgeFromVertex:@4 toVertex:@5];
    [self assert_shouldNotFindPathFromVertex:@5 toVertex:@4];
    [self assert_shouldFindPathFromVertex:@4 toVertex:@5];
}

- (void)testFindPathFromTerminalVertex
{
    [self.graph addEdgeFromVertex:@5 toVertex:@4];
    [self assert_shouldNotFindPathFromVertex:@4 toVertex:@5];
    [self assert_shouldFindPathFromVertex:@5 toVertex:@4];
}

- (void)testFindPathWithNoValidCandidate
{
    PCGPath *path = [self.pathFinder findPathInGraph:self.graph fromVertex:@1 toVertexPassingTest:^BOOL(PCGPathFinder *pathFinder, PCGDirectedGraph *graph, PCGVertex source, PCGVertex candidate, NSUInteger weight) {
        return false;
    }];
    XCTAssertNotNil(path, @"path should not be nil");
    XCTAssertFalse(path.vertices.count, @"should not had found a path");
}

@end
