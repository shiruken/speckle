[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.6657812.svg)](https://doi.org/10.5281/zenodo.6657812)

# Calculate Speckle Contrast

MATLAB functions for calculating spatial and temporal speckle contrast for performing [laser speckle contrast imaging](https://foil.bme.utexas.edu/project/laser-speckle-contrast-imaging/). Code developed for the [Functional Optical Imaging Laboratory (FOIL)](https://foil.bme.utexas.edu/) at the University of Texas at Austin.

* [`spatial_speckle_contrast(raw,w)`](spatial_speckle_contrast.m) - Calculate spatial speckle contrast
* [`temporal_speckle_contrast(raw,w)`](temporal_speckle_contrast.m) - Calculate temporal speckle contrast

## Inputs

* `raw` - Raw data in the form of an `MxNxn` matrix where `MxN` is the dimension of a single raw image and `n` is the number of raw images to be processed. _Note: Processing large quantities of images may require splitting the data into batches to avoid memory issues._
* `w` - Size of the sliding window (`wxw`) used during spatial speckle contrast calculation or the number of raw frames (`w`) used during temporal speckle contrast calcuation.

### Optional Arguments (Name-Value Pairs)

* `(___,'mode','gpu')` - Enable GPU processing on [compatible hardware](https://www.mathworks.com/help/parallel-computing/gpu-support-by-release.html). Defaults to CPU processing (`'cpu'`).
* `(___,'debug',true)` - Enable verbose diagnostic information about the processing. Disabled by default (`false`).

## Output

* `sc` - Matrix containing the calculated speckle contrast.
  * The output of [`spatial_speckle_contrast`](spatial_speckle_contrast.m) will be an `MxNxn` matrix. _Note: The outer `w/2` edge of pixels will contain unreliable information due to padding._
  * The output of [`temporal_speckle_contrast`](temporal_speckle_contrast.m) will be an `MxNx(n-w+1)` matrix.

## Benchmarking

Tested performance on PC running Windows 10 with Intel i7-9700K CPU and NVIDIA GeForce RTX 2060 GPU with `1200x1000x1000` dataset.

|                             |  w |   CPU   |   GPU   |
|----------------------------:|:--:|:-------:|:-------:|
|  `spatial_speckle_contrast` |  7 |  39 fps | 106 fps |
| `temporal_speckle_contrast` | 49 | 8.6 fps |  10 fps |

## Citation

> Colin Sullender. Calculate Speckle Contrast. (2022) doi:10.5281/zenodo.6657812.

<details><summary>BibTeX</summary>

```bibtex
@software{sullender:10.5281/zenodo.6657812,
  author       = {Colin Sullender},
  title        = {Calculate Speckle Contrast},
  month        = jun,
  year         = 2022,
  publisher    = {Zenodo},
  version      = {v1},
  doi          = {10.5281/zenodo.6657812},
  url          = {https://doi.org/10.5281/zenodo.6657812}
}
```

</details>

## Resources

* [Functional Optical Imaging Laboratory (FOIL)](https://foil.bme.utexas.edu/)
* [D. Boas and A. Dunn, Laser speckle contrast imaging in biomedical optics. _Journal of Biomedical Optics_ (2010)](https://doi.org/10.1117/1.3285504)
