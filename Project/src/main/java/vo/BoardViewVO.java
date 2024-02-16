package vo;

public class BoardViewVO extends BoardVO  {
	
		private String realFileName;    // 서버에 저장된 파일명
		private String foreignFileName; // 외부에서 온(클라에서) 파일명
		private int bfidx; 				// 이미지가 들어온 순서
		
		public int getBfidx() {
			return bfidx;
		}
		public void setBfidx(int bfidx) {
			this.bfidx = bfidx;
		}
		public String getRealFileName() {
			return realFileName;
		}
		public void setRealFileName(String realFileName) {
			this.realFileName = realFileName;
		}
		public String getForeignFileName() {
			return foreignFileName;
		}
		public void setForeignFileName(String foreignFileName) {
			this.foreignFileName = foreignFileName;
		}
}
