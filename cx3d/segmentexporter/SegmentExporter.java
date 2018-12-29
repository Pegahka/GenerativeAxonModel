package segmentexporter;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class SegmentExporter {
	private PrintWriter segmentoutput;
	private Boolean fileError = false;		
	
	private List<double []> segments = new LinkedList<double []>();			
	
	public SegmentExporter(String fileName) {
		try {
			segmentoutput = new PrintWriter(fileName,"UTF-8");
		} catch (FileNotFoundException e) {
			fileError = true;
			System.out.println("Unable to find the file");			
		} catch (UnsupportedEncodingException e) {
			fileError = true;
			System.out.println("Encoding not supported");
		}
	}
	
	public boolean generateOutput(List<Segment> segments) {
		if (fileError) 
			return false;
		
		int floretId = 1;				
		
		for (Segment segment : segments) {			
			if (segment.getLength() > 0) {
			
				while (!preProcessSegments(segment, true));
			
			if (segment != null) {
				exportCurrentSegmentToList(segment, 1, floretId);
			}
			floretId++; 		
			}
		}
		
		exportSegment();
		
		segmentoutput.close();
		return true;
	}
	
	
	private void exportCurrentSegmentToList(Segment segment, int depth, int floretId) {
		segments.add(new double[] {depth, segment.getLength(), floretId});
		
		if (segment.getLeft() != null) {
			exportCurrentSegmentToList(segment.getLeft(), depth + 1, floretId);
		}
		
		if (segment.getRight() != null) {
			exportCurrentSegmentToList(segment.getRight(), depth + 1, floretId);
		}
	}
	
	private Boolean preProcessSegments(Segment segment, Boolean processed) {
		
		if (segment.getLength() < 0 & processed) {						
			
			Segment sibling = segment.getSibling();
			
			if (sibling != null && sibling.getLength() > 0) {				
				segment.getParent().elongate(sibling.getLength());
				segment.getParent().setLeft(sibling.getLeft());
				segment.getParent().setRight(sibling.getRight());														
			} else {
				if (segment.getParent() != null) {					
					segment.getParent().setLeft(null);
					segment.getParent().setRight(null);
				}					
			}
			
			return false;
		} else {
			
			if (segment.getLeft() != null)
				processed = preProcessSegments(segment.getLeft(), processed);
			
			if (segment.getRight() != null)
				processed = preProcessSegments(segment.getRight(), processed);
			
			return processed;
		}
	}
	
	
	private void exportSegment() {
		for (double [] segment : segments) {
			segmentoutput.println(segment[0] + ", " + segment[1] + ", " + segment[2]);
		}		
	}
}
