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

/**
 The `PCGDirectedGraph` class is an implementation of a weighted directed graph (or weighted digraph, or network).
 ## Definition
 See http://en.wikipedia.org/wiki/Directed_graph for directed graph theory.
 ## Thread
 This class is not thread safe.
 */
@interface PCGDirectedGraph : NSObject

/** ----------------------------------------------------------------------------------------------------
 @name Initialization
 */

/**
 Creates, initialises and returns an empty `PCGDirectedGraph` object with default capacity.
 @return an empty `PCGDirectedGraph`
 */
+ (instancetype)directedGraph;

/**
 Creates, initialises and returns an empty `PCGDirectedGraph` object with the specified capacity.
 @param capacity the initial vertices container capacity
 @return an empty `PCGDirectedGraph`
 */
+ (instancetype)directedGraphWithCapacity:(NSUInteger)capacity;

/**
 Initialises and returns an empty `PCGDirectedGraph` object with default capacity.
 @return an empty `PCGDirectedGraph`
 */
- (instancetype)init;

/**
 Initialises and returns an empty `PCGDirectedGraph` object with the specified capacity.
 @param capacity the initial vertices container capacity
 @return an empty `PCGDirectedGraph`
 */
- (instancetype)initWithCapacity:(NSUInteger)capacity;

/** ----------------------------------------------------------------------------------------------------
 @name Adding vertices
 */

/**
 Add vertex `source` if it does not exist in this graph.
 @param source The source vertex
 */
- (void)addVertex:(PCGVertex)source;

/** ----------------------------------------------------------------------------------------------------
 @name Removing vertices
 */

/**
 Remove vertex `source` if it exists in this graph, removing also all edges going from and to it.
 @param source The source vertex
 */
- (void)removeVertex:(PCGVertex)source;

/** ----------------------------------------------------------------------------------------------------
 @name Adding edges
 */

/**
 Add or replace an edge from `source` to `target` vertices and then from `target` to `source`, both edges with `weight` of `1`,
 adding `source` and `target` vertices if they do not exist in this graph.
 @param source The source vertex
 @param target The target vertex
 */
- (void)addEdgesBetweenVertex:(PCGVertex)source andVertex:(PCGVertex)target;

/**
 Add or replace an edge from `source` to `target` vertices, with `weight` of `1`,
 adding `source` and `target` vertices if they do not exist in this graph.
 @param source The source vertex
 @param target The target vertex
 */
- (void)addEdgeFromVertex:(PCGVertex)source toVertex:(PCGVertex)target;

/**
 Add or replace an edge from `source` to `target` vertices and then from `target` to `source`, both edges with the specified `weight`,
 adding `source` and `target` vertices if they do not exist in this graph.
 @param source The source vertex
 @param target The target vertex
 @param weight The weight of the edges
 */
- (void)addEdgesBetweenVertex:(PCGVertex)source andVertex:(PCGVertex)target withWeight:(NSUInteger)weight;

/**
 Add or replace an edge from `source` to `target` vertices, with the specified `weight`,
 adding `source` and `target` vertices if they do not exist in this graph.
 @param source The source vertex
 @param target The target vertex
 @param weight The weight of the edge
 */
- (void)addEdgeFromVertex:(PCGVertex)source toVertex:(PCGVertex)target withWeight:(NSUInteger)weight;

/** ----------------------------------------------------------------------------------------------------
 @name Removing edges
 */

/**
 Remove edges if they exists in this graph between `source` and `target` vertices.
 @param source The source vertex
 @param target The target vertex
 */
- (void)removeEdgesBetweenVertex:(PCGVertex)source andVertex:(PCGVertex)target;

/**
 Remove edge if it exists in this graph from `source` to `target` vertices.
 @param source The source vertex
 @param target The target vertex
 */
- (void)removeEdgeFromVertex:(PCGVertex)source toVertex:(PCGVertex)target;

/**
 Remove edges if they exists in this graph going from `source` vertex to any vertices.
 @param source The source vertex
 */
- (void)removeEdgesFromVertex:(PCGVertex)source;

/**
 Remove edges if they exists in this graph going from any vertices to `target` vertex.
 @param target The target vertex
 */
- (void)removeEdgesToVertex:(PCGVertex)target;

@end
