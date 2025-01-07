package project;

public class MSComment {
	private int ms_cno;
	private int mno;
	private int uno;
	private String content;
	private String rdate;
	private String nickname;
	
	public MSComment() {}
	

	public MSComment(int ms_cno, int mno, int uno, String content, String rdate, String nickname) {
		super();
		this.ms_cno = ms_cno;
		this.mno = mno;
		this.uno = uno;
		this.content = content;
		this.rdate = rdate;
		this.nickname = nickname;
	}


	public int getMs_cno() {
		return ms_cno;
	}


	public void setMs_cno(int ms_cno) {
		this.ms_cno = ms_cno;
	}


	public int getMno() {
		return mno;
	}


	public void setMno(int mno) {
		this.mno = mno;
	}


	public int getUno() {
		return uno;
	}


	public void setUno(int uno) {
		this.uno = uno;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getRdate() {
		return rdate;
	}


	public void setRdate(String rdate) {
		this.rdate = rdate;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}



	
	
}
