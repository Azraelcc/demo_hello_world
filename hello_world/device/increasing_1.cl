__kernel void increasing(__global unsigned int *restrict data) {
    // Get index of the work item
    *data = *data + 1;
}