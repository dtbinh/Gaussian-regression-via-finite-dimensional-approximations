function RemoveIrrelevantEigenfunctions( tComputer, tParameters )
	%
	% find how many eigenfunctions shall be used
	afCapturedVariancesPercentiles =	...
		cumsum( tComputer.afEigenvalues )	...
		./								...
		sum( tComputer.afEigenvalues );
	%
	iLastEigenfunctionToConsider =									...
		find														...
		(															...
			(	afCapturedVariancesPercentiles						...
				<													...
				tParameters.fPercentageOfVarianceToBeCaptured	),	...
			1,														...
			'last'													...
		);
	%
	% cope with the parameters suggested by the user...
	iLastEigenfunctionToConsider =									...
		max(	iLastEigenfunctionToConsider,						...
				tParameters.iMinimalNumberOfEigenfunctionsToBeSaved	);
	%
	% ...but also check that the user did not say something that is not realistic
	iLastEigenfunctionToConsider =									...
		min(	numel(tComputer.afEigenvalues),						...
				tParameters.iMinimalNumberOfEigenfunctionsToBeSaved	);
	%
	% remove the unimportant eigenfunctions / eigenvalues
	switch( tComputer.tInputDomain.iNumberOfDimensions )
		%
		case 1
			%
			tComputer.ffEigenfunctions = ...
				tComputer.ffEigenfunctions(:, 1:iLastEigenfunctionToConsider);
		%
		case 2
			%
			tComputer.ffEigenfunctions = ...
				tComputer.ffEigenfunctions(:, :, 1:iLastEigenfunctionToConsider);
		%
		case 3
			%
			tComputer.ffEigenfunctions = ...
				tComputer.ffEigenfunctions(:, :, :, 1:iLastEigenfunctionToConsider);
		%
		otherwise
			%
			error('dimensionality not supported');
		%
	end;%
	%
	tComputer.afEigenvalues = ...
		tComputer.afEigenvalues(1:iLastEigenfunctionToConsider);
	%
	tComputer.iNumberOfEigenfunctions = numel( tComputer.afEigenvalues );
	%
end %
