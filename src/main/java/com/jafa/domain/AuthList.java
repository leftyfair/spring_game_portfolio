package com.jafa.domain;

import java.util.ArrayList;
import java.util.List;

public class AuthList {

	private List<AuthVO> authList;

    public AuthList() {
        authList = new ArrayList<>();
    }

    public List<AuthVO> getAuthList() {
        return authList;
    }

    public void setAuthList(List<AuthVO> authList) {
        this.authList = authList;
    }
}
