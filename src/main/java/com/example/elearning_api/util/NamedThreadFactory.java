package com.example.elearning_api.util;

import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

public class NamedThreadFactory implements ThreadFactory {
    private final String base ;
    private final AtomicInteger n = new AtomicInteger(1);
    public NamedThreadFactory(String base) {
        this.base = base;
    }
    @Override
    public Thread newThread(Runnable r) {
        return new Thread(r, base+"-"+n.getAndIncrement());
    }
}
