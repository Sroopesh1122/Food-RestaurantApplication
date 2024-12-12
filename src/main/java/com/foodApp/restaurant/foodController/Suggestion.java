package com.foodApp.restaurant.foodController;

import java.util.Objects;

public class Suggestion {
	String data = null;

	public Suggestion(String data) {
		this.data = data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getData() {
		return this.data;
	}

	@Override
	public boolean equals(Object obj) {
		Suggestion s = (Suggestion) obj;
		if (this == obj)
			return true; // Check for self-comparison
		else if (this.data.equalsIgnoreCase(s.getData())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return data.hashCode();
	}

	@Override
	public String toString() {
		return this.data;
	}
}
