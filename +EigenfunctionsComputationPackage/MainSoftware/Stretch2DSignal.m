function aafStretchedSignal = Stretch2DSignal(	aafOriginalSignal,	...
												afOriginalXAxis,	...
												afOriginalYAxis,	...
												afStretchedXAxis,	...
												afStretchedYAxis	)
	%
	% storage allocation
	aafSignalStretchedAlongXAxis =			...
		zeros(	numel( afStretchedXAxis ),	...
				numel( afOriginalYAxis )	);
	%
	aafStretchedSignal =					...
		zeros(	numel( afStretchedXAxis ),	...
				numel( afStretchedYAxis )	);
	%
	% stretch along x (one for each y sample)
	for iYSample = 1:numel( afOriginalYAxis )
		%
		aafSignalStretchedAlongXAxis(:, iYSample) =				...
			StretchSignal(	aafOriginalSignal( :, iYSample ),	...
							afOriginalXAxis,					...
							afStretchedXAxis					);
		%
	end;%
	%
	% stretch along y (one for each x sample -- NOW IN THE NEW X AXIS)
	for iXSample = 1:numel( afStretchedXAxis )
		%
		aafStretchedSignal(iXSample, :) =								...
			StretchSignal(	aafSignalStretchedAlongXAxis(iXSample, :),	...
							afOriginalYAxis,							...
							afStretchedYAxis							);
		%
	end;%
	%
end %
