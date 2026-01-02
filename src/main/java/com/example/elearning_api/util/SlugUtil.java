package com.example.elearning_api.util;

import java.text.Normalizer;

public final class SlugUtil {
    private SlugUtil(){}
    public static String normalize(String input) {
        String s = Normalizer.normalize(input, Normalizer.Form.NFD)
                .replaceAll("\\p{InCombiningDiacriticalMarks}+","")
                .toLowerCase().replaceAll("[^a-z0-9]+","-")
                .replaceAll("^-+|-+$","");
        return s.isBlank()? "course" : s;
    }
}
