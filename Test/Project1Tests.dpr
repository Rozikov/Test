program Project1Tests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestPhisicsControllerUnit in 'TestPhisicsControllerUnit.pas',
  AccessAdapterUnit in '..\AccessAdapterUnit.pas',
  AdaptersUnit in '..\AdaptersUnit.pas',
  ControllersUnit in '..\ControllersUnit.pas',
  MainUnit in '..\MainUnit.pas',
  MenuUnit in '..\MenuUnit.pas',
  PhisicsControllerUnit in '..\PhisicsControllerUnit.pas',
  Test1Unit in '..\Test1Unit.pas',
  TestsUnit in '..\TestsUnit.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

