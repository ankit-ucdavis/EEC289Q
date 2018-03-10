#include "spokes.cu"
#include "propagate.cu"
#include "explore.cu"
#include <stdint.h>
#include <curand_kernel.h>


__global__ void RSD_Imp(real3* d_points, uint32_t* d_neighbors, int NPoints, uint32_t* d_delaunay, const int MaxOffset, curandState* globalState){

	int tid = threadIdx.x + blockIdx.x * blockDim.x;

	if (tid > NPoints){ return; }
	
	uint3 exploredID;
	real3 sharedVertex;
	
	explore(tid,
	        d_points,
	        d_neighbors,
	        MaxOffset,
	        globalState, tid,
	        exploredID,
	        sharedVertex);

	// Now we have 3 neighbors and a vertex:
	//Propagate(tid,exploredID, sharedVertex, d_delaunay);

}