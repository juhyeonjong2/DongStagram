package vo;

public class SearchContentVO {
	private String type; // user or hashTag
	private String searchWords; // 검색어 (닉네임 or hashTag)
	
	// userInfo
	private String name;
	private String profileImage;
	private String intro;
	private int followers;
	
	// hashTagInfo
	private int boards; // 게시물 수

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSearchWords() {
		return searchWords;
	}

	public void setSearchWords(String searchWords) {
		this.searchWords = searchWords;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public int getFollowers() {
		return followers;
	}

	public void setFollowers(int followers) {
		this.followers = followers;
	}

	public int getBoards() {
		return boards;
	}

	public void setBoards(int boards) {
		this.boards = boards;
	}
	
	
	
}
