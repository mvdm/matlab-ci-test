import matlab.unittest.TestSuite;
import matlab.unittest.TestRunner;
import matlab.unittest.plugins.TAPPlugin;
import matlab.unittest.plugins.ToFile;
import('matlab.unittest.plugins.CodeCoveragePlugin');
import('matlab.unittest.plugins.codecoverage.CoberturaFormat');

try
    suite = testsuite;
    % Create a typical runner with text output
    runner = TestRunner.withTextOutput();
    % Add the TAP plugin and direct its output to a file
    tapFile = fullfile(getenv('WORKSPACE'), 'testResults.tap');
    runner.addPlugin(TAPPlugin.producingOriginalFormat(ToFile(tapFile)));
    % Add cobertura output
    coverageFile = fullfile(getenv('WORKSPACE'), 'coverage.xml');
    runner.addPlugin(CodeCoveragePlugin.forFolder(src,'Producing', CoberturaFormat(coverageFile)));
    % Run the tests
    results = runner.run(suite);
    display(results);
catch e
    disp(getReport(e,'extended'));
    %exit(1);
end
%exit;

%% non-TAP version
% import matlab.unittest.TestSuite;
% 
% try
%     suite = testsuite;
%     results = run(suite);
%     display(results);
% catch e
%     disp(getReport(e,'extended'));
%     exit(1);
% end
% exit(any([results.Failed]));