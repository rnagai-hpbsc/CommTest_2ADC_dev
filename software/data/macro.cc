#include <stdio.h>
#include <iostream>
#include <fstream>
#include <sstream>

void macro(string file,string ofile)
{
  ifstream ifs(file.c_str());
  string str;

  int addr1 = -1;
  int addr2 = -1;
  int inbs1 = -1;
  int inbs2 = -1;

  TH1D *h1 = new TH1D("h1",";ADC value;Entry",16384,0,16384);
  TH1D *h2 = new TH1D("h2",";ADC value;Entry",16384,0,16384);

  TH1D *w1 = new TH1D("w1",";#clock count;ADC value",50000,0,50000);

  int xmin = -1;
  int xmax = -1;

  while (getline(ifs,str)) 
  {
    istringstream stream(str);
    istringstream alt1(str);
    int a, b, c;
    char cma;
    stream >> a >> cma >> b >> cma >> c;
    if (','!=cma) {
      string alta, altb;
      int altc = -1;
      alt1 >> alta;
      if ("Address"==alta) {
        alt1 >> altb >> altc;
        if (addr1==-1) addr1 = altc;
        else addr2 = altc;
      }
      if ("Input"==alta)  {
        alt1 >> altb >> altb >> altc;
        if (inbs1==-1) inbs1 = altc;
        else inbs2 = altc;
      }
      //if (altc!=-1) cout << alta << altc << endl;
      continue;
    }
    if (a==0 | a==1) continue; 
    h1->Fill(b);
    h2->Fill(c);
    w1->Fill(a,b);
    int evmin = (b < c) ? b : c;
    int evmax = (b > c) ? b : c;
    xmin = (xmin==-1 | xmin > evmin) ? evmin : xmin;
    xmax = (xmax==-1 | xmax < evmax) ? evmax : xmax;
    //cout << a << "|" << cma << "|" << b << "|" << cma << "|" <<  c << " || " << str <<  endl; 
  }

  TCanvas *c1 = new TCanvas("c1","c1",0,0,800,600);
  c1->SetGrid();
  c1->Draw();

  int xdif = xmax - xmin; 
  h1->GetXaxis()->SetRangeUser(xmin-xdif,xmax+xdif);
  h1->Draw();
  h1->Fit("gaus");
  h2->Draw("same");
  h2->Fit("gaus");

  float mean1 = h1->GetFunction("gaus")->GetParameter(1);
  float mean2 = h2->GetFunction("gaus")->GetParameter(1);
  float sigma1 = h1->GetFunction("gaus")->GetParameter(2);
  float sigma2 = h2->GetFunction("gaus")->GetParameter(2);
  float sgerr1 = h1->GetFunction("gaus")->GetParError(2);
  float sgerr2 = h2->GetFunction("gaus")->GetParError(2);


  ofstream ofs(ofile.c_str(),ios::app);

  cout << inbs1 << " " << inbs2 << " " << mean1 << "+/-" << sigma1 << " " << mean2 << "+/-" << sigma2 << endl;
  ofs << inbs1 << " " << inbs2 << " " << mean1 << " " << sigma1 << " " << sgerr1 << " " <<
    mean2 << " " << sigma2 << " " << sgerr2 << endl;

  return;
}
