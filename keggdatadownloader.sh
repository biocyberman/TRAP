#!/bin/bash
: '

keggdatadownloader - A simple script to download KEGG data for species

Created by Vang Quy Le (vql) on 2016-02-13.
Last modified Time-stamp: <2016-03-21 15:27:27 vql>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

----------------------------------------------------------------------
'

### CUSTOMIZATION THE FOLLOWING FOR YOUR SPECIES ###

ORGF=rattus_norvegicus
ORG=rno # Organism code as listed in http://www.kegg.jp/kegg/catalog/org_list.html

## FINISH CUSTOMIZATION ## 
mkdir -p $ORGF
cd $ORGF

f=kegg_${ORG}_keggID_geneID.txt
if [ ! -f "$f" ]; then
wget -O $f http://rest.kegg.jp/list/${ORG}
fi

PATHWAYNAME=kegg_${ORG}_pathwayname.txt
if [ ! -f "$PATHWAYNAME" ]; then
wget -O ${PATHWAYNAME} http://rest.kegg.jp/list/pathway/${ORG}
fi

KGML=${ORG}_kgml
mkdir -p $KGML 
for p in $(cut -f1 $PATHWAYNAME|sed 's/path://'); do
    wget -O ${KGML}/${p}.xml http://rest.kegg.jp/get/${p}/kgml 
done
cd -
