package ezen;

public enum GenderType {
	 UNKNOWN(0),
	 FEMAL(1),
	 MALE(2);
	 
	private final int value;
    private GenderType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
