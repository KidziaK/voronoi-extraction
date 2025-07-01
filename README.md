# Installation

1) Download official docker image of NVDNet from https://www.dropbox.com/scl/fi/p5zi97igmiygv2x69row7/NVD.tar?rlkey=l5o7hx5qu1zymxd7k4wln1pfq&e=1&st=sh5fjmfk&dl=0
2) Run the following command to import downloaded image `cat NVD.tar | docker import - nvd_release:v0`

# Usage
- Use `extract_voronoi_from_single_ply()` directly on .ply point cloud. The result Voronoi boundaries will be save to .npy in the same location as original point cloud.
- Use `voronoi_boundary_to_voronoi_cell()` to convert Voronoi boundaries into Voronoi cells. The result would again be saved in the same location as original point cloud.

# Reference
NVDNet implementation comes from the repository of the original paper https://github.com/yilinliu77/NVDNet.

`@article {liu_sig24,
  author = {Yilin Liu and Jiale Chen and Shanshan Pan and Daniel Cohen-Or and Hao Zhang and Hui Huang},
  title = {{Split-and-Fit}: Learning {B-Reps} via Structure-Aware {Voronoi} Partitioning},
  journal = {ACM Transactions on Graphics (Proc. of SIGGRAPH)},
  volume = {43},
  number = {4},
  pages = {108:1--108:13},
  year = {2024}
}`
