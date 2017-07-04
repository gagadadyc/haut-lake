package com.imdyc.hautlake.util;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by gagada on 2017/7/1.
 */
public class ResponseUtil {
    //将结果result通过response输出
    public static void print(HttpServletResponse response, Object result) throws IOException {
        //修改响应信息的编码
        response.setContentType("text/html; charset=UTF-8");
        //将响应结果通过response输出到请求页面
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();//清空输出缓存
        out.close();//关闭输出流
    }
}
