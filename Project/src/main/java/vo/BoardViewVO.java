package vo;

public class BoardViewVO extends BoardVO  {
	
		// ����� �߰�.
		private String realFileName;    // ������ ����� ���ϸ�
		private String foreignFileName; // �ܺο��� ��(Ŭ�󿡼�) ���ϸ� 
		
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
