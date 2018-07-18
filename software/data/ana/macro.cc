#include <stdio.h>
#include <iostream>
#include <fstream>

int macro(string file, float timeinterval=4.)
{
  ifstream ifs(file.c_str());

  int counter = 0;
  int inittime = 0;
  int time, wave, wave2;
  int xmin = 0;
  int xmax = 0;
  int xmin2 = 0;
  int xmax2 = 0;
  int endfl = 0;
  int endfl2 = 0;

  int adc1min = -1;
  int adc1max = -1;
  int adc2min = -1;
  int adc2max = -1;

  TH1F *h1 = new TH1F("Waveform1",";Time [ns];ADC value",500,0,500*timeinterval);
  TH1F *h2 = new TH1F("Waveform2",";Time [ns];ADC value",500,0,500*timeinterval);
  TF1 *func  = new TF1("func" ,"[0]*sin(2*TMath::Pi()*[1]*(x-[2]))+[3]",0,300);
  TF1 *func2 = new TF1("func2","[0]*sin(2*TMath::Pi()*[1]*(x-[2]))+[3]",0,300);

  TH1F *prj1 = new TH1F("Distribution1",";ADC value;Entry",16384,0,16384);
  TH1F *prj2 = new TH1F("Distribution2",";ADC value;Entry",16384,0,16384);

  while (!ifs.eof()) 
  {
    ifs >> time >> wave >> wave2;
    if (counter==0) inittime = time;
    int localtime = (time - inittime)*timeinterval;
    h1->Fill(localtime,wave);
    h2->Fill(localtime,wave2);
    prj1->Fill(wave);
    prj2->Fill(wave2);
    cout << localtime << " " << wave << " " << wave2 << " " << xmax2 << endl; 
    
    if (xmin==0 && wave!=0) {
      xmin = localtime;
      xmax = localtime;
    }
    if (xmax!=0 && wave==0 && endfl==0) {
      xmax = localtime;
      endfl = 1;
    }

    if (xmin2==0 && wave2!=0) {
      xmin2 = localtime;
      xmax2 = localtime;
    }
    if (xmax2!=0 && wave2==0 && endfl2==0) {
      xmax2 = localtime;
      endfl2 = 1;
    }

    if (adc1min==-1 && wave!=0) adc1min = wave;
    if (adc1max==-1 && wave!=0) adc1max = wave;
    if (adc2min==-1 && wave2!=0) adc2min = wave2;
    if (adc2max==-1 && wave2!=0) adc2max = wave2;

    if (adc1min>wave) adc1min = wave;
    if (adc1max<wave) adc1max = wave;
    if (adc2min>wave2) adc2min = wave2;
    if (adc2max<wave2) adc2max = wave2;

    counter++;
    if (counter==100000) break;
  }

  cout << "xmin: " << xmin << " xmax:" << xmax << " xmin2:" << xmin2 << " xmax2:" << xmax2 << endl;

  TCanvas *c1 = new TCanvas("c1","c1",0,0,800,600);
  c1->SetGrid();

  h1->SetLineColor(kBlack);
  h1->Draw("HIST");
  h1->GetYaxis()->SetRangeUser(0,16384);
  h1->GetYaxis()->SetTitleOffset(1.47);
  float ymax = h1->GetMaximum();
  func->SetParameter(0,ymax);
  func->SetParameter(1,.002);
  func->SetParameter(2,xmin);
  func->SetParameter(3,0);
  //func->SetParLimits(0,ymax*.8,ymax*1.2);
  func->SetParLimits(1,.003,.007);
  //func->SetParLimits(2,xmin*.8,xmin*1.2);
  //func->SetParLimits(3,-100,+100);
  //h1->Fit("func","","",xmin-1,xmax-1);
  //func->Draw("same");
  float freq = func->GetParameter(1)*1e3; // MHz
  cout << freq << " MHz" << endl;

  h2->SetLineColor(kBlue);
  h2->Draw("HISTsame");
  func2->SetParameters(ymax, .002, xmin2, 0);
  func2->SetParLimits(1,.003,.007);
  //h2->Fit("func2","","",xmin2-1,xmax2-1);
  //func2->Draw("same");

  TCanvas *c2 = new TCanvas("c2","c2",800,0,800,600);
  c2->SetGrid();

  float d1max = prj1->GetMaximum();
  float d2max = prj2->GetMaximum();
  float distmax = (d1max>d2max) ? d1max : d2max; 
  prj1->GetYaxis()->SetRangeUser(0.,distmax*1.2);
  prj1->SetLineColor(kBlack);
  prj1->Draw("HIST");
  prj1->Fit("gaus","","",adc1min,adc1max);
  prj2->SetLineColor(kBlue);
  prj2->Draw("HISTsame");
  prj2->Fit("gaus","","",adc2min,adc2max);

  TF1 *fit1 = prj1->GetFunction("gaus");
  TF1 *fit2 = prj2->GetFunction("gaus");
  fit1->SetLineColor(kBlack);
  fit2->SetLineColor(kBlue);
  fit1->Draw("same");
  fit2->Draw("same");


  return 0;

}
