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

#import "PCGraph.h"

#import "PCGDirectedGraph+Private.h"

@implementation PCGDirectedGraph

+ (instancetype)directedGraph
{
    return [[self alloc] init];
}

+ (instancetype)directedGraphWithCapacity:(NSUInteger)capacity
{
    return [[self alloc] initWithCapacity:capacity];
}

- (instancetype)init
{
    if (self = [super init])
        self.edges = [NSMutableDictionary dictionary];
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity
{
    if (self = [super init])
        self.edges = [NSMutableDictionary dictionaryWithCapacity:capacity];
    return self;
}

- (void)ensureEdgesExistsForVertex:(PCGVertex)source
{
    if (!self.edges[source])
        self.edges[source] = [NSMutableDictionary dictionaryWithCapacity:5];
}

- (void)addVertex:(PCGVertex)source
{
    NSAssert(source, @"Source vertex can not be nil.");
    [self ensureEdgesExistsForVertex:source];
}

- (void)removeVertex:(PCGVertex)source
{
    NSAssert(source, @"Source vertex can not be nil.");
    [self removeEdgesFromVertex:source];
    [self removeEdgesToVertex:source];
    [self.edges removeObjectForKey:source];
}

- (void)addEdgesBetweenVertex:(PCGVertex)source andVertex:(PCGVertex)target
{
    [self addEdgesBetweenVertex:source andVertex:target withWeight:1];
}

- (void)addEdgeFromVertex:(PCGVertex)source toVertex:(PCGVertex)target
{
    [self addEdgeFromVertex:source toVertex:target withWeight:1];
}

- (void)addEdgesBetweenVertex:(PCGVertex)source andVertex:(PCGVertex)target withWeight:(NSUInteger)weight
{
    [self addEdgeFromVertex:source toVertex:target withWeight:weight];
    [self addEdgeFromVertex:target toVertex:source withWeight:weight];
}

- (void)addEdgeFromVertex:(PCGVertex)source toVertex:(PCGVertex)target withWeight:(NSUInteger)weight
{
    NSAssert(source, @"Source vertex can not be nil.");
    NSAssert(target, @"Target vertex can not be nil.");
    [self ensureEdgesExistsForVertex:source];
    [self ensureEdgesExistsForVertex:target];
    self.edges[source][target] = @(weight);
}

- (void)removeEdgesBetweenVertex:(PCGVertex)source andVertex:(PCGVertex)target
{
    [self removeEdgeFromVertex:source toVertex:target];
    [self removeEdgeFromVertex:target toVertex:source];
}

- (void)removeEdgeFromVertex:(PCGVertex)source toVertex:(PCGVertex)target
{
    NSAssert(source, @"Source vertex can not be nil.");
    NSAssert(target, @"Target vertex can not be nil.");
    [self.edges[source] removeObjectForKey:target];
}

- (void)removeEdgesFromVertex:(PCGVertex)source
{
    NSAssert(source, @"Source vertex can not be nil.");
    [self.edges[source] removeAllObjects];
}

- (void)removeEdgesToVertex:(PCGVertex)target
{
    NSAssert(target, @"Target vertex can not be nil.");
    [self.edges enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [(NSMutableDictionary *)obj removeObjectForKey:target];
    }];
}

@end
