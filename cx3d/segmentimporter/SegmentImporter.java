package segmentimporter;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

import segmentexporter.*;


public class SegmentImporter {
	
	private List<double []> segmentsRaw = new LinkedList<double []>();
	private List<Segment> constructedSegments = new LinkedList<Segment>();
	
	public List<Segment> getSegments() {
		return constructedSegments;
	}
	
	public void constructRawStructureFromCsv(Scanner scanner) {
		int depth;
		double length;
		int floretId;		

		while (scanner.hasNext()) {
			try {
				depth = scanner.nextInt();
				length = scanner.nextDouble();
				floretId = scanner.nextInt(); 

				segmentsRaw.add(new double [] {depth, length, floretId});
			} catch (Exception e) {
				System.out.println("Maybe remove commas?? Parse error...");
			}						
		}
	}

	public void constructFlorets() {
		int currentFloretId = 0;
		int nextFloretId = 0;
		
		List<double []> currentFloret = new LinkedList<double []>();
		
		for (double []  rawSegment : segmentsRaw) {
			
			nextFloretId = (int) rawSegment[2];
			
			if (currentFloret.isEmpty()) {
				currentFloretId = nextFloretId;
			}					
			
			if (currentFloretId != nextFloretId) {
				constructedSegments.add(processFloret(currentFloret));
				currentFloret = new LinkedList<double []>();
			}
			
			currentFloret.add(new double [] {rawSegment[0], rawSegment[1]});
			currentFloretId = (int) rawSegment[2];		
		}
		
		constructedSegments.add(processFloret(currentFloret));
	}
	
	private Segment processFloret(List<double []> currentFloret) {
		int floretSize = currentFloret.size();
		System.out.println(floretSize);
		Segment [] segments = new Segment[floretSize];
		double [][] currentFloretMat = new double[floretSize][2];
		
		int segmentIndex = 0;
		for (double [] segment : currentFloret) {
			segments[segmentIndex] = new Segment(segment[1]);
			currentFloretMat[segmentIndex][0] = segment[0];
			currentFloretMat[segmentIndex][1] = segment[1];
			segmentIndex++;
		}
		
		for (int i=0; i < floretSize - 1; i++) {
			if (currentFloretMat[i][0] == currentFloretMat[i + 1][0] - 1) {
				segments[i].setLeft(segments[i+1]);
				
				int depth = (int) currentFloretMat[i + 1][0];
				for (int j = i + 2; j < floretSize; j++) { 
					if (currentFloretMat[j][0] == depth) {
						segments[i].setRight(segments[j]);
						break;
					}
				}
			}
		}
		
		return segments[0];
	}

	public static void main(String[] args) {
		Scanner scanner;
		try {
			scanner = new Scanner(new File("outM3.csv"));
			SegmentImporter si = new SegmentImporter();
			si.constructRawStructureFromCsv(scanner);
			si.constructFlorets();
			SegmentsHandler sh = new SegmentsHandler();
			
			sh.setSegmentList(si.getSegments());
			sh.generateOutput();
		} catch (FileNotFoundException e) {

			System.out.println("Unable to import CSV file. I'm sorry...");
		}
	}
}
