function sc = spatial_speckle_contrast(raw, w, varargin)
%spatial_speckle_contrast Calculate spatial speckle contrast
% sc = spatial_speckle_contrast(raw, w) Calculate spatial speckle contrast 
% from raw data using specified window size.
%
%   raw = Intensity data as [MxNxn] matrix
%   w = Spatial window size in pixels (must be odd)
%
% spatial_speckle_contrast(___,Name,Value) modifies processing using one or
% more name-value pair arguments.
%
%   'mode': Specify processing mode (Default = 'cpu')
%       Options include 'cpu' or 'gpu'. GPU processing requires compatible
%       graphics card.
%
%   'debug': Enable verbose output (Default = false)
%
%
% Author: Colin Sullender (csullender@utexas.edu)
% Functional Optical Imaging Laboratory (FOIL) - foil.bme.utexas.edu
% University of Texas at Austin
%

p = inputParser;
addRequired(p, 'raw', @isnumeric);
validationFcn = @(x) assert(isnumeric(x) && isscalar(x) && (x > 1) && (mod(x,2) == 1), ...
                            'Window size must be an odd scalar greater than 1.');
addRequired(p, 'w', validationFcn);
addParameter(p, 'mode', 'cpu', @(x) any(validatestring(x, {'cpu', 'gpu'})));
addParameter(p, 'debug', false, @islogical);
parse(p, raw, w, varargin{:});

raw = p.Results.raw;
w = p.Results.w;
mode = p.Results.mode;
debug = p.Results.debug;

if debug
  fprintf('Calculating spatial speckle contrast:\n');
  fprintf('  Data: %dx%dx%d\n', size(raw, 1), size(raw, 2), size(raw, 3));
  fprintf('  Window Size: %d\n', w);
  fprintf('  Processing Mode: %s\n', mode);
end

sc = zeros(size(raw), 'single');
N = size(raw, 3);

func_sc = @(x) stdfilt(x, ones(w)) ./ imfilter(x, ones(w) / (w ^ 2));

tic;
if strcmp(mode, 'gpu')
  for i = 1:N
    frame = gpuArray(single(raw(:, :, i)));
    sc(:,:,i) = gather(func_sc(frame));
  end
else % mode = 'cpu'
  for i = 1:N
    frame = single(raw(:, :, i));
    sc(:,:,i) = func_sc(frame);
  end
end

if debug
  fprintf('Elapsed Time: %.2fs (%.1fs fps)\n', toc, N/toc);
end

end