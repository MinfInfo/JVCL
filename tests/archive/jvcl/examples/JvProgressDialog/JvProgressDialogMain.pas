unit JvProgressDialogMain;
{
  Demo for JvProgressDialog: shows off most important properties and events.
  Component is created at run-time so does not need to be installed but the units
  JvProgressDialog.pas and JvProgressFrm.pas must be on the path
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GIFImage, ExtCtrls, JvProgressDialog, jpeg, ExtDlgs,
  JvComponent;

type
  TfrmProgressDialogDemo = class(TForm)
    btnExecute: TButton;
    Image1: TImage;
    chkShowLogo: TCheckBox;
    chkShowCancel: TCheckBox;
    Label1: TLabel;
    edCaption: TEdit;
    Label2: TLabel;
    edText: TEdit;
    chkShowEvents: TCheckBox;
    btnSelectImage: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    chkTransparent: TCheckBox;
    chkShowModal: TCheckBox;
    procedure btnExecuteClick(Sender: TObject);
    procedure btnSelectImageClick(Sender: TObject);
  private
    { Private declarations }
    FCancelPosition: integer;
    procedure DoDialogClose(Sender: TObject);
    procedure DoDialogShow(Sender: TObject);
    procedure DoDialogProgress(Sender: TObject; var AContinue: boolean);
    procedure DoDialogCancel(Sender: TObject);
    procedure DoModalShow;
    procedure DoNonModalShow;
  public
    { Public declarations }
    pd: TJvProgressDialog;
  end;

var
  frmProgressDialogDemo: TfrmProgressDialogDemo;

implementation

{$R *.dfm}

procedure TfrmProgressDialogDemo.DoModalShow;
const
  cCancel: array[boolean] of PChar = ('', 'not ');
begin
  // OnProgress and Interval is used in modal mode
  pd.OnProgress := DoDialogProgress;
  if chkShowEvents.Checked then
    // Execute returns true if the dialog was closed without user intervention
    // and false if the user clicked the Cancel button (or hit Esc when Cancel button is visible)
    ShowMessageFmt('User did %scancel according to Execute', [cCancel[pd.Execute]])
  else
    pd.Execute;
end;

procedure TfrmProgressDialogDemo.DoNonModalShow;
begin
  // Show, Hide and Cancelled is used in non-modal mood
  pd.OnProgress := nil; // not needed
  pd.Show;
  while pd.Position <= pd.Max do // just loop...
  begin
    if pd.Cancelled then Break;
    pd.Position := pd.Position + Random(10);
    pd.Text := Format(edText.Text, [pd.Position]);
    sleep(pd.Interval);
    Application.ProcessMessages;
  end;
  pd.Hide;
end;

procedure TfrmProgressDialogDemo.btnExecuteClick(Sender: TObject);
begin
  FCancelPosition := -1;
  Randomize;
  // set everything up according to user choice
  if pd = nil then
    pd := TJvProgressDialog.Create(self);
  pd.Caption := edCaption.Text;
  pd.Text := edText.Text;
  pd.ShowCancel := chkShowCancel.Checked;
  pd.Interval := 100 + Random(1000);
  if chkShowLogo.Checked then
  begin
    pd.Image := Image1.Picture;
    pd.Transparent := chkTransparent.Checked;
  end;
  // set up events
  pd.OnCancel := DoDialogCancel;
  pd.OnShow := DoDialogShow;
  pd.OnClose := DoDialogClose;
  if chkShowModal.Checked then
    DoModalShow
  else
    DoNonModalShow;
  // Here's an example on how to determine *when* the user cancelled the dialog
  // The FCancelPosition value is updated in DoDialogCancel below:
  if FCancelPosition >= 0 then
    ShowMessageFmt('The user cancelled at position %d', [FCancelPosition]);
end;

procedure TfrmProgressDialogDemo.DoDialogShow(Sender: TObject);
begin
  if chkShowEvents.Checked then
    ShowMessage('OnShow: showing dialog');
  // set initial value
  pd.Text := Format(edText.Text, [pd.Position]);
end;

procedure TfrmProgressDialogDemo.DoDialogClose(Sender: TObject);
begin
  if chkShowEvents.Checked then
    ShowMessage('OnClose: dialog closed');
end;

procedure TfrmProgressDialogDemo.DoDialogCancel(Sender: TObject);
begin
  // notice that the ShowMessage always appears *before* the progress dialog is hidden
  if chkShowEvents.Checked then
    ShowMessage('OnCancel: User cancelled');
  // save the position where the user cancelled:
  FCancelPosition := pd.Position;
end;

procedure TfrmProgressDialogDemo.DoDialogProgress(Sender: TObject; var AContinue: boolean);
begin
  // notice that you change the properties of the dialog component
  // and these changes are reflected in the dialog
  pd.Position := pd.Position + Random(10);
  pd.Text := Format(edText.Text, [pd.Position]);
  // AContinue controls if the dialog should remain visible or not
  AContinue := pd.Position <= pd.Max;
end;

procedure TfrmProgressDialogDemo.btnSelectImageClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    Image1.Picture.LoadFromFile(OpenPictureDialog1.Filename);
end;


end.

