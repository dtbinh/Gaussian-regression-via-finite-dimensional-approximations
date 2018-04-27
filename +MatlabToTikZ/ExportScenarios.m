function ExportScenarios(			...
			tScenariosGenerator,	...
			strTxtFilename,			...
		   	iNumberOfScenarios		)
	%
	iNumberOfSamplesPerScenario	= numel(tScenariosGenerator.aafOriginalSamples(1, :));
	%
	afSamplingTimesInHours =										...
				(1:iNumberOfSamplesPerScenario)'					...
		   	*	( tScenariosGenerator.fSamplingTimeInSeconds / 3600 );
	%
	% compute the envelope of the scenarios - consider that they
	% are 'by row'
	afSupremumEnvelope 		=																				...
		(																									...
			max																								...
			(																								...
				tScenariosGenerator.aafOriginalSamples														...
				(																							...
					iNumberOfSamplesPerScenario : (iNumberOfSamplesPerScenario + iNumberOfScenarios + 1),	...
					:																						...
				)																							...
			)																								...
		)';
	%
	% this is the infimum of the envelope
	afInfimumEnvelope 		=																				...
		(																									...
			min																								...
			(																								...
				tScenariosGenerator.aafOriginalSamples														...
				(																							...
					iNumberOfSamplesPerScenario : (iNumberOfSamplesPerScenario + iNumberOfScenarios + 1),	...
					:																						...
				)																							...
			)																								...
		)';
	%
	% once one has the envelope one can export the scenarios and the envelopes
	aafToBeExportedSamples =
		[																									...
			afSamplingTimesInHours,																			...
			afSupremumEnvelope,																				...
			afInfimumEnvelope,																				...
			tScenariosGenerator.aafOriginalSamples															...	
			(																								...	
				iNumberOfSamplesPerScenario : (iNumberOfSamplesPerScenario + iNumberOfScenarios + 1),		...
				:																							...	
			)'																								...	
		];
	%
	% construct the header
	astrHeader = [ {'timeInHours'}, {'supremum'}, {'infimum'} ];
	%
	for iScenario = iNumberOfSamplesPerScenario:iNumberOfSamplesPerScenario+iNumberOfScenarios+1;
		%
		astrHeader = [ astrHeader, {sprintf('scenario%d', iScenario-iNumberOfSamplesPerScenario)} ];
		%
	end;%
	%
	% then export everything
	MatlabToTikZ.ExportLineplot(strTxtFilename, aafToBeExportedSamples, astrHeader);
	%
% 	% TODO
% 	str100PCConfidenceIntervalsFilename = strcat(strTxtFilename, '100');
% 	str80PCConfidenceIntervalsFilename = strcat(strTxtFilename, '80');
% 	%
% 	MatlabToTikZ.ExportAreaplot(str100PCConfidenceIntervalsFilename, afSamplingTimesInHours, afSupremumEnvelope, afInfimumEnvelope);
% 	MatlabToTikZ.ExportAreaplot(str80PCConfidenceIntervalsFilename, afSamplingTimesInHours, 0.8*afSupremumEnvelope, 0.8*afInfimumEnvelope);
	%
end % function

