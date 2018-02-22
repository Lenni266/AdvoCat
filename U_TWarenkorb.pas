unit U_TWarenkorb;

interface

uses FMX.Grid, U_RVG, U_Utils;

type
  TRVGFunc = function (streitwert: real): real;

  TWarenkorb = class
  public
    Content: TIntArray;
    Functions: array[0..12] of TRVGFunc;

    procedure Add(itemId: integer; aGrid: TGrid);
    procedure Update(aGrid: TGrid);

    function getPrice(itemId: integer; streitwert: real):real;

    constructor Create;

    const
      Names: array[0..12] of string = (
      {0}   ('Brief'),

      {1}   ('Brief-Mahn'),
      {2}   ('Brief-Mahn-Klage-Gericht-Verlieren'),
      {3}   ('Brief-Mahn-Klage-Vergleich'),
      {4}   ('Brief-Mahn-Klage-Berufung'),

      {5}   ('Brief-Mahn-Vollbesch'),
      {6}   ('Brief-Mahn-VollBesch-Voll'),
      {7}   ('Brief-Mahn-VollBesch-Klage-Gericht-Verlieren'),
      {8}   ('Brief-Mahn-VollBesch-Klage-Vergleich'),
      {9}   ('Brief-Mahn-VollBesch-Klage-Berufung'),

      {10}   ('Klage-Gericht-Verlieren'),

      {11}   ('Klage-Vergleich'),

      {12}   ('Klage-Berufung')
      );
end;

implementation


constructor TWarenkorb.Create;
begin
  SetLength(Content, 0);

  Functions[0] := @U_RVG.calcBrief;

  Functions[1] := @U_RVG.calcBriefMahn;
  Functions[2] := @U_RVG.calcBriefMahnKlageGerichtVerlieren;
  Functions[3] := @U_RVG.calcBriefMahnKlageVergleich;
  Functions[4] := @U_RVG.calcBriefMahnKlageBerufung;

  Functions[5] := @U_RVG.calcBriefMahnvollBesch;
  Functions[6] := @U_RVG.calcBriefMahnvollBeschVoll;

  Functions[7] := @U_RVG.calcBriefMahnVollBeschKlageGerichtVerlieren;
  Functions[8] := @U_RVG.calcBriefMahnVollBeschKlageVergleich;
  Functions[9] := @U_RVG.calcBriefMahnVollBeschKlageBerufung;

  Functions[10] := @U_RVG.calcKlageGerichtVerlieren;

  Functions[11] := @U_RVG.calcKlageVergleich;

  Functions[12] := @U_RVG.calcKlageBerufung;
end;

procedure TWarenkorb.Add(itemId: integer; aGrid: TGrid);
begin
  if itemId < 13 then
  begin
    SetLength(Content, Length(Content) + 1);
    Content[High(Content)] := itemId;
    Update(aGrid);
  end;
end;

procedure TWarenkorb.Update(aGrid: TGrid);
begin
  aGrid.BeginUpdate;
  aGrid.RowCount := Length(Content);
  aGrid.EndUpdate;
end;

function TWarenkorb.getPrice(itemId: integer; streitwert: real):real;
begin
  if itemId < 13 then
    result := trunc(Functions[itemId](streitwert) * 100) / 100;
end;




end.
