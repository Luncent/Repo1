package model;

public class ProviderInfo {
	int id;
    String name;
	
	public ProviderInfo(int id, String name) {
		this.id=id;
		this.name=name;
	}
	
	public int getID() {
		return id;
	}
	
	public String getName() {
		return name;
	}
}
