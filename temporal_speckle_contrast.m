function sc = temporal_speckle_contrast(raw, w, varargin)
%temporal_speckle_contrast Calculate temporal speckle contrast
% sc = temporal_speckle_contrast(raw, w) Calculate temporal speckle contrast
% from raw data using specified window size.
%
%   raw = Intensity data as [MxNxn] matrix
%   w = Temporal window size in frames
%
% temporal_speckle_contrast(___,Name,Value) modifies processing using one or
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
validationFcn = @(x) assert(isnumeric(x) && isscalar(x) && (x > 1), ...
                            'Window size must be a scalar greater than 1.');
addRequired(p, 'w', validationFcn);
addParameter(p, 'mode', 'cpu', @(x) any(validatestring(x, {'cpu', 'pool', 'gpu'})));
addParameter(p, 'debug', false, @islogical);
parse(p, raw, w, varargin{:});

raw = p.Results.raw;
w = p.Results.w;
mode = p.Results.mode;
debug = p.Results.debug;

if debug
  fprintf('Calculating temporal speckle contrast:\n');
  fprintf('  Data: %dx%dx%d\n', size(raw, 1), size(raw, 2), size(raw, 3));
  fprintf('  Window Size: %d\n', w);
  fprintf('  Processing Mode: %s\n', mode);
end

N = size(raw, 3) - w + 1;
sc = zeros(size(raw, 1), size(raw, 2), N, 'single');

func_sc = @(x) std(x, [], 3) ./ mean(x, 3);

tic;
if strcmp(mode, 'gpu')
  for i = 1:N
    frames = gpuArray(single(raw(:,:,i:i + w - 1)));
    sc(:,:,i) = gather(func_sc(frames));
  end
else % mode = 'cpu'
  for i = 1:N
    frames = single(raw(:,:,i:i + w - 1));
    sc(:,:,i) = func_sc(frames);
  end
end

if debug
  fprintf('Elapsed Time: %.2fs (%.1fs fps)\n', toc, N/toc);
end

end