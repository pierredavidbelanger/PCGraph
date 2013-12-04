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

@implementation PCGPathFinderDijkstra

- (PCGPath *)findPathInGraph:(PCGDirectedGraph *)graph fromVertex:(PCGVertex)source toVertexPassingTest:(PCGGVertexPredicate)predicate
{
    NSAssert(source, @"Source vertex can not be nil.");
    NSAssert(predicate, @"Target predicate can not be nil.");
    
    PCGPath *path = [[PCGPath alloc] init];
    
    NSArray *vertices = graph.edges.allKeys;
    if (!source || ![vertices containsObject:source])
        return path;
    
    NSUInteger count = vertices.count;
    NSMutableDictionary *dist = [NSMutableDictionary dictionaryWithCapacity:count];
    NSMutableDictionary *visited = [NSMutableDictionary dictionaryWithCapacity:count];
    NSMutableDictionary *previous = [NSMutableDictionary dictionaryWithCapacity:count];
    NSMutableArray *q = [NSMutableArray arrayWithCapacity:count];
    
    for (NSNumber *v in vertices) {
        dist[v] = @(NSUIntegerMax);
        visited[v] = @NO;
        previous[v] = [NSNull null];
    }
    
    dist[source] = @0;
    [q addObject:source];
    
    PCGVertex target = nil;
    
    while (q.count > 0) {
        
        NSNumber *u = nil;
        NSUInteger ud = NSUIntegerMax;
        for (NSNumber *tu in q) {
            BOOL tuv = [visited[tu] boolValue];
            if (tuv)
                continue;
            NSUInteger tud = [dist[tu] unsignedIntegerValue];
            if (tud < ud) {
                u = tu;
                ud = tud;
            }
        }
        
        if (predicate(self, graph, source, u, [dist[u] unsignedIntegerValue])) {
            target = u;
            break;
        }
        
        [q removeObject:u];
        visited[u] = @YES;
        
        NSDictionary *edges = graph.edges[u];
        if (!edges)
            continue;
        
        for (NSNumber *v in edges.allKeys) {
            
            NSUInteger uvd = [edges[v] unsignedIntegerValue];
            NSUInteger alt = ud + uvd;
            
            NSUInteger vd = [dist[v] unsignedIntegerValue];
            if (alt < vd) {
                
                dist[v] = @(alt);
                previous[v] = u;
                
                BOOL vv = [visited[v] boolValue];
                if (!vv)
                    [q addObject:v];
            }
        }
    }
    
    if (!target)
        return path;
    
    NSMutableArray *s = [NSMutableArray array];
    PCGVertex u = target;
    while (u && ![u isEqual:[NSNull null]]) {
        [s insertObject:u atIndex:0];
        u = previous[u];
    }
    path.vertices = s;
    path.weight = [dist[target] unsignedIntegerValue];
    
    return path;
}

@end
