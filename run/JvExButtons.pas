{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExButtons.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas.Hausladen@gmx.de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

Last Modified: 2004-01-12

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
{$I jvcl.inc}

unit JvExButtons;
interface
uses
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, Buttons, StdCtrls,
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Qt, QGraphics, QControls, QForms, QButtons, QStdCtrls,
  {$ENDIF VisualCLX}
  Classes, SysUtils,
  JvThemes, JvExControls;

{$IFDEF VCL}
 {$DEFINE NeedMouseEnterLeave}
{$ELSE}
 {$IF not declared(PatchedVCLX)}
  {$DEFINE NeedMouseEnterLeave}
 {$IFEND}
{$ENDIF VCL}

type
  TJvExSpeedButton = class(TSpeedButton, IJvControlEvents)
  {$IFDEF VCL}
  protected
  { IJvControlEvents }
    procedure VisibleChanged; dynamic;
    procedure EnabledChanged; dynamic;
    procedure TextChanged; dynamic;
    procedure FontChanged; dynamic;
    procedure ColorChanged; dynamic;
    procedure ParentFontChanged; dynamic;
    procedure ParentColorChanged; dynamic;
    procedure ParentShowHintChanged; dynamic;
    function WantKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; virtual;
    function HintShow(var HintInfo: THintInfo): Boolean; dynamic;
    function HitTest(X, Y: Integer): Boolean; dynamic;
    procedure MouseEnter(Control: TControl); dynamic;
    procedure MouseLeave(Control: TControl); dynamic;
  {$IFNDEF HASAUTOSIZE}
   {$IFNDEF COMPILER6_UP}
    procedure SetAutoSize(Value: Boolean); virtual;
   {$ENDIF !COMPILER6_UP}
  {$ENDIF !HASAUTOSIZE}
  public
    procedure Dispatch(var Msg); override;
  {$ENDIF VCL}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  {$IFDEF NeedMouseEnterLeave}
  private
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
  protected
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  {$ENDIF NeedMouseEnterLeave}
  protected
    function DoPaintBackground(Canvas: TCanvas; Param: Integer): Boolean; virtual;
  {$IFDEF VisualCLX}
   {$IF not declared(PatchedVCLX)}
  protected
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
   {$IFEND}
  {$ENDIF VisualCLX}
  end;
  
  TJvExBitBtn = class(TBitBtn, IJvWinControlEvents, IJvControlEvents)
  {$IFDEF VCL}
  protected
  { IJvControlEvents }
    procedure VisibleChanged; dynamic;
    procedure EnabledChanged; dynamic;
    procedure TextChanged; dynamic;
    procedure FontChanged; dynamic;
    procedure ColorChanged; dynamic;
    procedure ParentFontChanged; dynamic;
    procedure ParentColorChanged; dynamic;
    procedure ParentShowHintChanged; dynamic;
    function WantKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; virtual;
    function HintShow(var HintInfo: THintInfo): Boolean; dynamic;
    function HitTest(X, Y: Integer): Boolean; dynamic;
    procedure MouseEnter(Control: TControl); dynamic;
    procedure MouseLeave(Control: TControl); dynamic;
  {$IFNDEF HASAUTOSIZE}
   {$IFNDEF COMPILER6_UP}
    procedure SetAutoSize(Value: Boolean); virtual;
   {$ENDIF !COMPILER6_UP}
  {$ENDIF !HASAUTOSIZE}
  { IJvWinControlEvents }
    procedure CursorChanged; dynamic;
    procedure ShowingChanged; dynamic;
    procedure ShowHintChanged; dynamic;
    procedure ControlsListChanging(Control: TControl; Inserting: Boolean); dynamic;
    procedure ControlsListChanged(Control: TControl; Inserting: Boolean); dynamic;
  {$IFDEF JVCLThemesEnabledD56}
  private
    function GetParentBackground: Boolean;
  protected
    procedure SetParentBackground(Value: Boolean); virtual;
    property ParentBackground: Boolean read GetParentBackground write SetParentBackground;
  {$ENDIF JVCLThemesEnabledD56}
    {$IFDEF VisualCLX}
    function NeedKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; override;
    {$ENDIF VisualCLX}
    procedure DoGetDlgCode(var Code: TDlgCodes); virtual;
  public
    procedure Dispatch(var Msg); override;
  {$ENDIF VCL}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  {$IFDEF NeedMouseEnterLeave}
  private
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
  protected
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  {$ENDIF NeedMouseEnterLeave}
  protected
    function DoPaintBackground(Canvas: TCanvas; Param: Integer): Boolean; virtual;
  {$IFDEF VisualCLX}
   {$IF not declared(PatchedVCLX)}
  protected
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
   {$IFEND}
  private
    FCanvas: TCanvas;
  protected
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
    procedure Paint; virtual;
    property Canvas: TCanvas read FCanvas;
  {$ENDIF VisualCLX}
  end;
  

implementation


{$IFDEF VCL}
procedure TJvExSpeedButton.VisibleChanged;
begin
  InheritMsg(Self, CM_VISIBLECHANGED);
end;

procedure TJvExSpeedButton.EnabledChanged;
begin
  InheritMsg(Self, CM_ENABLEDCHANGED);
end;

procedure TJvExSpeedButton.TextChanged;
begin
  InheritMsg(Self, CM_TEXTCHANGED);
end;

procedure TJvExSpeedButton.FontChanged;
begin
  InheritMsg(Self, CM_FONTCHANGED);
end;

procedure TJvExSpeedButton.ColorChanged;
begin
  InheritMsg(Self, CM_COLORCHANGED);
end;

procedure TJvExSpeedButton.ParentColorChanged;
begin
  InheritMsg(Self, CM_PARENTCOLORCHANGED);
end;

procedure TJvExSpeedButton.ParentFontChanged;
begin
  InheritMsg(Self, CM_PARENTFONTCHANGED);
end;

procedure TJvExSpeedButton.ParentShowHintChanged;
begin
  InheritMsg(Self, CM_PARENTSHOWHINTCHANGED);
end;

function TJvExSpeedButton.WantKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := InheritMsg(Self, CM_DIALOGCHAR, Word(Key), ShiftStateToKeyData(Shift)) <> 0;
end;

function TJvExSpeedButton.HintShow(var HintInfo: THintInfo): Boolean;
begin
  Result := InheritMsg(Self, CM_HINTSHOW, 0, Integer(@HintInfo)) <> 0;
end;

function TJvExSpeedButton.HitTest(X, Y: Integer): Boolean;
begin
  Result := InheritMsg(Self, CM_HITTEST, 0, Integer(PointToSmallPoint(Point(X, Y)))) <> 0;
end;

procedure TJvExSpeedButton.MouseEnter(Control: TControl);
begin
  InheritMsg(Self, CM_MOUSEENTER, 0, Integer(Control));
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TJvExSpeedButton.MouseLeave(Control: TControl);
begin
  InheritMsg(Self, CM_MOUSELEAVE, 0, Integer(Control));
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

{$IFNDEF HASAUTOSIZE}
 {$IFNDEF COMPILER6_UP}
procedure TJvExSpeedButton.SetAutoSize(Value: Boolean);
begin
  TOpenControl_SetAutoSize(Self, Value);
end;
 {$ENDIF !COMPILER6_UP}
{$ENDIF !HASAUTOSIZE}

{$ENDIF VCL}

function TJvExSpeedButton.DoPaintBackground(Canvas: TCanvas; Param: Integer): Boolean;
begin
  {$IFDEF VCL}
  Result := InheritMsg(Self, WM_ERASEBKGND, Canvas.Handle, Param) <> 0;
  {$ELSE}
  Result := False; // Qt allways paints the background
  {$ENDIF VCL}
end;

{$IFDEF VisualCLX}
 {$IF not declared(PatchedVCLX)}
procedure TJvExSpeedButton.MouseEnter(Control: TControl);
begin
  inherited MouseEnter(Control);
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TJvExSpeedButton.MouseLeave(Control: TControl);
begin
  inherited MouseLeave(Control);
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;
 {$IFEND}
{$ENDIF VisualCLX}
{$IFDEF VCL}
procedure TJvExSpeedButton.Dispatch(var Msg);
begin
  DispatchMsg(Self, Msg);
end;
{$ENDIF VCL}
constructor TJvExSpeedButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
end;

destructor TJvExSpeedButton.Destroy;
begin
  
  inherited Destroy;
end;

{$IFDEF VCL}
procedure TJvExBitBtn.VisibleChanged;
begin
  InheritMsg(Self, CM_VISIBLECHANGED);
end;

procedure TJvExBitBtn.EnabledChanged;
begin
  InheritMsg(Self, CM_ENABLEDCHANGED);
end;

procedure TJvExBitBtn.TextChanged;
begin
  InheritMsg(Self, CM_TEXTCHANGED);
end;

procedure TJvExBitBtn.FontChanged;
begin
  InheritMsg(Self, CM_FONTCHANGED);
end;

procedure TJvExBitBtn.ColorChanged;
begin
  InheritMsg(Self, CM_COLORCHANGED);
end;

procedure TJvExBitBtn.ParentColorChanged;
begin
  InheritMsg(Self, CM_PARENTCOLORCHANGED);
end;

procedure TJvExBitBtn.ParentFontChanged;
begin
  InheritMsg(Self, CM_PARENTFONTCHANGED);
end;

procedure TJvExBitBtn.ParentShowHintChanged;
begin
  InheritMsg(Self, CM_PARENTSHOWHINTCHANGED);
end;

function TJvExBitBtn.WantKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := InheritMsg(Self, CM_DIALOGCHAR, Word(Key), ShiftStateToKeyData(Shift)) <> 0;
end;

function TJvExBitBtn.HintShow(var HintInfo: THintInfo): Boolean;
begin
  Result := InheritMsg(Self, CM_HINTSHOW, 0, Integer(@HintInfo)) <> 0;
end;

function TJvExBitBtn.HitTest(X, Y: Integer): Boolean;
begin
  Result := InheritMsg(Self, CM_HITTEST, 0, Integer(PointToSmallPoint(Point(X, Y)))) <> 0;
end;

procedure TJvExBitBtn.MouseEnter(Control: TControl);
begin
  InheritMsg(Self, CM_MOUSEENTER, 0, Integer(Control));
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TJvExBitBtn.MouseLeave(Control: TControl);
begin
  InheritMsg(Self, CM_MOUSELEAVE, 0, Integer(Control));
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

{$IFNDEF HASAUTOSIZE}
 {$IFNDEF COMPILER6_UP}
procedure TJvExBitBtn.SetAutoSize(Value: Boolean);
begin
  TOpenControl_SetAutoSize(Self, Value);
end;
 {$ENDIF !COMPILER6_UP}
{$ENDIF !HASAUTOSIZE}

{$ENDIF VCL}

function TJvExBitBtn.DoPaintBackground(Canvas: TCanvas; Param: Integer): Boolean;
begin
  {$IFDEF VCL}
  Result := InheritMsg(Self, WM_ERASEBKGND, Canvas.Handle, Param) <> 0;
  {$ELSE}
  Result := False; // Qt allways paints the background
  {$ENDIF VCL}
end;

{$IFDEF VisualCLX}
 {$IF not declared(PatchedVCLX)}
procedure TJvExBitBtn.MouseEnter(Control: TControl);
begin
  inherited MouseEnter(Control);
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TJvExBitBtn.MouseLeave(Control: TControl);
begin
  inherited MouseLeave(Control);
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;
 {$IFEND}
{$ENDIF VisualCLX}

procedure TJvExBitBtn.DoGetDlgCode(var Code: TDlgCodes);
begin
end;

{$IFDEF VisualCLX}
procedure TJvExBitBtn.Painting(Sender: QObjectH; EventRegion: QRegionH);
begin
  if WidgetControl_Painting(Self, Canvas, EventRegion) <> nil then
  begin // returns an interface
    DoPaintBackground(Canvas, 0);
    Paint;
  end;
end;

function TWidgetControl.NeedKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := TWidgetControl_NeedKey(Self, Key, Shift, KeyText,
    inherited NeedKey(Key, Shift, KeyText));
end;

{$ENDIF VisualCLX}
{$IFDEF VCL}
procedure TJvExBitBtn.CursorChanged;
begin
  InheritMsg(Self, CM_CURSORCHANGED);
end;

procedure TJvExBitBtn.ShowHintChanged;
begin
  InheritMsg(Self, CM_SHOWHINTCHANGED);
end;

procedure TJvExBitBtn.ShowingChanged;
begin
  InheritMsg(Self, CM_SHOWINGCHANGED);
end;

procedure TJvExBitBtn.ControlsListChanging(Control: TControl; Inserting: Boolean);
begin
  Control_ControlsListChanging(Self, Control, Inserting);
end;

procedure TJvExBitBtn.ControlsListChanged(Control: TControl; Inserting: Boolean);
begin
  Control_ControlsListChanged(Self, Control, Inserting);
end;

{$IFDEF JVCLThemesEnabledD56}
function TJvExBitBtn.GetParentBackground: Boolean;
begin
  Result := JvThemes.GetParentBackground(Self);
end;

procedure TJvExBitBtn.SetParentBackground(Value: Boolean);
begin
  JvThemes.SetParentBackground(Self, Value);
end;
{$ENDIF JVCLThemesEnabledD56}
{$ENDIF VCL}
{$IFDEF VisualCLX}
procedure TJvExBitBtn.Paint;
begin
  WidgetControl_DefaultPaint(Self, Canvas);
end;
{$ENDIF VisualCLX}
{$IFDEF VCL}
procedure TJvExBitBtn.Dispatch(var Msg);
begin
  DispatchMsg(Self, Msg);
end;

constructor TJvExBitBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
end;

destructor TJvExBitBtn.Destroy;
begin
  
  inherited Destroy;
end;
{$ENDIF VCL}
{$IFDEF VisualCLX}
constructor TJvExBitBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  
end;

destructor TJvExBitBtn.Destroy;
begin
  
  FCanvas.Free;
  inherited Destroy;
end;
{$ENDIF VisualCLX}
  

end.
