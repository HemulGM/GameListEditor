program GameListEditorFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Types,
  GLE.Main in 'GLE.Main.pas' {FormMain},
  GLE.Help in 'GLE.Help.pas' {FormHelp},
  GLE.NameEditor in 'GLE.NameEditor.pas' {FormNameEditor},
  GLE.DownloadThread in 'GLE.DownloadThread.pas',
  GLE.Game in 'GLE.Game.pas',
  GLE.Resources in 'GLE.Resources.pas',
  HGM.FMX.Image in 'HGM.FMX.Image.pas',
  WinUI3.Dialogs.DataTransferManager in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Dialogs.DataTransferManager.pas',
  WinUI3.Dialogs in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Dialogs.pas',
  WinUI3.Form.Dialog in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Form.Dialog.pas',
  WinUI3.Form in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Form.pas',
  WinUI3.Frame.Dialog.ColorPicker in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Dialog.ColorPicker.pas' {FrameDialogColorPicker: TFrame},
  WinUI3.Frame.Dialog.Font in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Dialog.Font.pas' {FrameDialogFont: TFrame},
  WinUI3.Frame.Dialog.Input in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Dialog.Input.pas' {FrameDialogInput: TFrame},
  WinUI3.Frame.Dialog in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Dialog.pas' {FrameDialog: TFrame},
  WinUI3.Frame.Dialog.Text in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Dialog.Text.pas' {FrameDialogText: TFrame},
  WinUI3.Frame.Inner.Dialog in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Inner.Dialog.pas' {FrameInnerDialog: TFrame},
  WinUI3.Frame.Inner.InfoBar in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Frame.Inner.InfoBar.pas' {FrameInnerInfoBar: TFrame},
  WinUI3.Style in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Style.pas',
  WinUI3.Utils in '..\Libraries\DelphiWinUI3\Sources\WinUI3.Utils.pas',
  HGM.ColorUtils in '..\Libraries\DelphiWinUI3\Sources\HGM.ColorUtils.pas',
  DX.Pdf.API in '..\Libraries\DX.Pdfium4D\src\DX.Pdf.API.pas',
  DX.Pdf.Document in '..\Libraries\DX.Pdfium4D\src\DX.Pdf.Document.pas',
  DX.Pdf.Renderer.FMX in '..\Libraries\DX.Pdfium4D\src\DX.Pdf.Renderer.FMX.pas',
  DX.Pdf.Viewer.Core in '..\Libraries\DX.Pdfium4D\src\DX.Pdf.Viewer.Core.pas',
  DX.Pdf.Viewer.FMX in '..\Libraries\DX.Pdfium4D\src\DX.Pdf.Viewer.FMX.pas',
  FmxPasLibVlcPlayerUnit in '..\Libraries\VLC\FmxPasLibVlcPlayerUnit.pas',
  PasLibVlcClassUnit in '..\Libraries\VLC\PasLibVlcClassUnit.pas',
  PasLibVlcUnit in '..\Libraries\VLC\PasLibVlcUnit.pas',
  FMX.Windows.Dispatch in '..\Libraries\DelphiWinUI3\FMXWindowsDispatch\FMX.Windows.Dispatch.pas',
  FMX.Windows.Hints in '..\Libraries\DelphiWinUI3\FMXWindowsHint\FMX.Windows.Hints.pas',
  DelphiWindowStyle.Core.Win in '..\Libraries\DelphiWinUI3\DelphiWindowStyle\DelphiWindowStyle.Core.Win.pas',
  DelphiWindowStyle.FMX in '..\Libraries\DelphiWinUI3\DelphiWindowStyle\DelphiWindowStyle.FMX.pas',
  DelphiWindowStyle.Types in '..\Libraries\DelphiWinUI3\DelphiWindowStyle\DelphiWindowStyle.Types.pas',
  FMX.Menus in '..\Libraries\DelphiWinUI3\Fixes\D13\FMX.Menus.pas',
  FMX.Platform.Win in '..\Libraries\DelphiWinUI3\Fixes\D13\FMX.Platform.Win.pas',
  FMX.StyledContextMenu in '..\Libraries\DelphiWinUI3\Fixes\D13\FMX.StyledContextMenu.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
