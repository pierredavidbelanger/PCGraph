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

@class PCGPathFinder;

typedef BOOL (^PCGGVertexPredicate)(PCGPathFinder *pathFinder, PCGDirectedGraph *graph, PCGVertex source, PCGVertex candidate, NSUInteger weight);

/**
 The `PCGPathFinder` is an abstract class that defines methods used to find a path in a `PCGDirectedGraph`.
 
 This class should not be instantiated; instead, one of its subcass should be used (e.g.: `PCGPathFinderDijkstra`).
 */
@interface PCGPathFinder : NSObject

/** ----------------------------------------------------------------------------------------------------
 @name Initialization
 */

/**
 Creates, initialises and returns an `PCGPathFinder` object.
 
 This method should be called using a `PCGPathFinder` subclass:
 
    PCGPathFinder *pathFinder = [PCGPathFinderDijkstra pathFinder];
 
 @return a `PCGPathFinder`
 */
+ (instancetype)pathFinder;

/**
 Initialises and returns an `PCGPathFinder` object.
 
 This method should be called using a `PCGPathFinder` subclass:
 
    PCGPathFinder *pathFinder = [[PCGPathFinderDijkstra alloc] init];
 
 @return a `PCGPathFinder`
 */
- (instancetype)init;

/** ----------------------------------------------------------------------------------------------------
 @name Finding a path
 */

/**
 Perform a search in the specified `graph` for a (shortest) path between the specified `source` and `target` vertices.
 @param graph The `PCGDirectedGraph`
 @param source The source vertex
 @param target The target vertex
 @return a `PCGPath`
 */
- (PCGPath *)findPathInGraph:(PCGDirectedGraph *)graph fromVertex:(PCGVertex)source toVertex:(PCGVertex)target;

/**
 Perform a search in the specified `graph` for a (shortest) path between the specified `source` vertex 
 and an other vertex that pass the test in the specified `predicate` block.
 @param graph The `PCGDirectedGraph`
 @param source The source vertex
 @param predicate The predicate block
 @return a `PCGPath`
 */
- (PCGPath *)findPathInGraph:(PCGDirectedGraph *)graph fromVertex:(PCGVertex)source toVertexPassingTest:(PCGGVertexPredicate)predicate;

@end
