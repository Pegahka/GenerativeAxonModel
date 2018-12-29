package segmentexporter;

import java.util.LinkedList;
import java.util.List;

public class SegmentsHandler {
		
	private SegmentExporter segmentexporter;	
	
	private List<Segment> segmentlist = new LinkedList<Segment>();
	
	public void addSegment(Segment segment) {		
		segmentlist.add(segment);		
	}
	
	public void setSegmentList(List<Segment> segments) {
		this.segmentlist = segments;
	}
	
	
	public void generateOutput() {
		segmentexporter = new SegmentExporter("out.csv");
		segmentexporter.generateOutput(segmentlist);
	}
	
}
