package project;

// DB Comment 테이블과 매핑되는 엔티티 클래스
public class Comment {
	private int cno;
	private int ano;
	private int uno;
	private String content;
	private String rdate;
	private String nickname;
	
	public Comment() {}
	

	public Comment(int cno, int ano, int uno, String content, String rdate, String nickname) {
		super();
		this.cno = cno;
		this.ano = ano;
		this.uno = uno;
		this.content = content;
		this.rdate = rdate;
		this.nickname = nickname;
	}


	public int getCno() {
		return cno;
	}


	public void setCno(int cno) {
		this.cno = cno;
	}


	public int getAno() {
		return ano;
	}


	public void setAno(int ano) {
		this.ano = ano;
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
