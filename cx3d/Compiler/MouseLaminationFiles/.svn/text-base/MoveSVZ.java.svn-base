/*
Copyright (C) 2009, 2010 Universität Zürich,
Eidgenossische Technische Hochschule (ETH) Zürich,
Andreas Hauri, Roman Bauer, Toby Weston.

This file is part of CX3D.

CX3D is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

CX3D is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with CX3D.  If not, see <http://www.gnu.org/licenses/>.
*/

	// Do NOT change the following comments, they will be set automatically by SVN.
	// $LastChangedRevision: 2246 $
	// $LastChangedDate: 2010-08-27 17:39:45 +0200 (Fri, 27 Aug 2010) $
	// $LastChangedBy: amw $


package ini.cx3d.cells.geneNetwork2;

import gcode2.SomaMachine;
import ini.cx3d.Param;

public class MoveSVZ extends SomaMachine {

	
	public void run() {
		writeMorphColor(Param.SEA_GREEN);
		writeMorphInterObjectForceCoefficient(val(0));
		if(LBigger(readPositionNotAllowed().YNotAllowed(),MAdd(val(40),Mrand(val(10)))).eval())
		{
			kill();
			return;
		}
		move(val(0,1,0),val(100),val(0),val(1),val(0.3));
	}
	
}
