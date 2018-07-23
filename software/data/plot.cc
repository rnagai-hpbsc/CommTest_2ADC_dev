#include <stdio.h>
#include <iostream>
#include <fstream>

void plot(string file)
{
  TH1D *h1 = new TH1D("h1",";DAC value;ADC value",65536,0,65536);
  TH1D *h2 = new TH1D("h2",";DAC value;ADC Noise",65536,0,65536);

  ifstream ifs(file.c_str()); 

  TGraphErrors *g1 = new TGraphErrors();
  TGraphErrors *g2 = new TGraphErrors();
  TGraphErrors *g1_1 = new TGraphErrors();
  TGraphErrors *g2_1 = new TGraphErrors();

  while (!ifs.eof()) 
  {
    float inbs1, inbs2, adc1, sig1, err1, adc2, sig2, err2;
    ifs >> inbs1 >> inbs2 >> adc1 >> sig1 >> err1 >> adc2 >> sig2 >> err2;
    
    int n = g1->GetN();
    g1->Set(n+1);
    g1->SetPoint(n,inbs1,adc1);
    g1->SetPointError(n,0,sig1);
    g2->Set(n+1);
    g2->SetPoint(n,inbs2,adc2);
    g2->SetPointError(n,0,sig2);
    g1_1->Set(n+1);
    g1_1->SetPoint(n,inbs1,sig1);
    g1_1->SetPointError(n,0,err1);
    g2_1->Set(n+1);
    g2_1->SetPoint(n,inbs2,sig2);
    g2_1->SetPointError(n,0,err2);
  }

  g1->SetMarkerColor(kBlack);
  g1->SetLineColor(kBlack);
  g1_1->SetMarkerColor(kBlack);
  g1_1->SetLineColor(kBlack);

  g2->SetMarkerColor(kBlue);
  g2->SetLineColor(kBlue);
  g2_1->SetMarkerColor(kBlue);
  g2_1->SetLineColor(kBlue);

  TCanvas *c1 = new TCanvas("c1","c1",0,0,800,600);
  c1->SetGrid();
  c1->Draw();

  h1->GetYaxis()->SetRangeUser(0,16384);
  h1->Draw();
  g1->Draw("PEsame");
  g2->Draw("PEsame");

  TCanvas *c2 = new TCanvas("c2","c2",800,0,800,600);
  c2->SetGrid();
  c2->Draw();

  h2->GetYaxis()->SetRangeUser(0,5);
  h2->Draw();
  g1_1->Draw("PEsame");
  g2_1->Draw("PEsame");

  return;
}
