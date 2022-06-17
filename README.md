# Calculate Speckle Contrast

MATLAB functions for calculating spatial and temporal speckle contrast for performing [laser speckle contrast imaging](https://foil.bme.utexas.edu/project/laser-speckle-contrast-imaging/). Code developed for the [Functional Optical Imaging Laboratory (FOIL)](https://foil.bme.utexas.edu/) at the University of Texas at Austin.

* `spatial_speckle_contrast(raw,w)`: Calculate spatial speckle contrast
* `temporal_speckle_contrast(raw,w)`: Calculate temporal speckle contrast

Both functions accept an `MxNxn` matrix (`raw`) as an input where `MxN` is the dimension of a single raw image and `n` is the number of raw images to be processed. _Note: Processing large quantities of images may require splitting the data into batches to avoid memory issues._ The window size argument (`w`) defines either a) the size of the sliding window used during spatial speckle contrast calculation or b) the number of raw frames used during temporal speckle contrast calculation. The functions default to CPU processing but can utilize a [compatible GPU](https://www.mathworks.com/help/parallel-computing/gpu-support-by-release.html) by defining the (`'mode','gpu'`) name-value pair argument. Diagnostic information about the processing can be enabled using the (`'debug', true`) name-value pair argument.