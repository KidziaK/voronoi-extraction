import subprocess
import shutil

import numpy as np

from pathlib import Path
from scipy.ndimage import label
from tqdm import tqdm


def extract_voronoi_from_single_ply(input_file: Path) -> None:
    tmp_dir = input_file.parent.joinpath("poisson")
    tmp_dir.mkdir(parents=True, exist_ok=True)

    shutil.copy(str(input_file), str(tmp_dir))

    run_template = Path("run_template.sh").read_text()
    run_template = run_template.replace("${INPUT_ROOT}", str(input_file.parent))

    subprocess.run(run_template, shell=True)
    shutil.rmtree(str(tmp_dir))


def voronoi_boundary_to_voronoi_cell(boundary_file: Path) -> None:
    boundaries = np.load(boundary_file)

    labels, _ = label(boundaries, structure=np.ones((3,3,3), dtype=bool))

    np.save(boundary_file.parent / "voronoi_cells.npy", labels)


if __name__ == "__main__":
    root_path = Path("data")

    for abc in tqdm(list(root_path.iterdir())):
        input_point_cloud = abc / "input.ply"

        if not input_point_cloud.exists():
            continue

        extract_voronoi_from_single_ply(input_point_cloud)

        voronoi_boundary_path = abc / "voronoi_boundaries.npy"

        voronoi_boundary_to_voronoi_cell(voronoi_boundary_path)
