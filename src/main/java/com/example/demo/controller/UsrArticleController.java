package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {

    // 의존성 주입
    @Autowired
    private Rq rq;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private ReactionPointService reactionPointService;

    public UsrArticleController() {
    }

    // 게시글 리스트를 보여주는 메서드
    @RequestMapping("/usr/article/list")
    public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int boardId,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
                           @RequestParam(defaultValue = "") String searchKeyword) {

        // 현재 요청의 Rq 객체를 가져옴
        Rq rq = (Rq) req.getAttribute("rq");

        // 게시판 정보를 가져옴
        Board board = boardService.getBoardById(boardId);

        // 해당 게시판의 게시글 수를 가져옴
        int articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);

        // 게시판이 존재하지 않을 경우 에러 메시지를 반환
        if (board == null) {
            return rq.historyBackOnView("없는 게시판이야");
        }

        // 한 페이지에 표시할 게시글 수
        int itemsInAPage = 10;

        // 총 페이지 수 계산
        int totalPage = (int) Math.ceil(articlesCount / (double) itemsInAPage);

        // 화면에 표시할 페이지 수
        int pageSize = 10;
        int pageGroup = (int) Math.ceil((double) page / pageSize);
        int from = ((pageGroup - 1) * pageSize) + 1;
        int end = pageGroup * pageSize;

        // 게시글 리스트를 가져옴
        List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode, searchKeyword);

        // 뷰에 필요한 데이터를 설정
        req.setAttribute("searchKeyword", searchKeyword);
        req.setAttribute("page", page);
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("pageGroup", pageGroup);
        req.setAttribute("from", from);
        req.setAttribute("end", end);

        // 모델에 필요한 데이터를 추가
        model.addAttribute("board", board);
        model.addAttribute("boardId", boardId);
        model.addAttribute("page", page);
        model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("articlesCount", articlesCount);
        model.addAttribute("articles", articles);

        // 뷰 이름 반환
        return "usr/article/list";
    }

    // 게시글 상세 내용을 보여주는 메서드
    @RequestMapping("/usr/article/detail")
    public String showDetail(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        // 게시글 정보를 가져옴
        Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        // 사용자의 반응 정보를 가져옴
        ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);

        // 반응 가능 여부를 모델에 추가
        if (usersReactionRd.isSuccess()) {
            model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
        }

        // 댓글 리스트를 가져옴
        List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);
        int repliesCount = replies.size();

        // 모델에 댓글 및 반응 정보 추가
        model.addAttribute("isAlreadyAddGoodRp2", reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "reply"));
        model.addAttribute("isAlreadyAddBadRp2", reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "reply"));
        model.addAttribute("repliesCount", repliesCount);
        model.addAttribute("replies", replies);
        model.addAttribute("article", article);
        model.addAttribute("isAlreadyAddGoodRp", reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
        model.addAttribute("isAlreadyAddBadRp", reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));

        // 뷰 이름 반환
        return "usr/article/detail";
    }

    // 조회수 증가 처리 메서드
    @RequestMapping("/usr/article/doIncreaseHitCountRd")
    @ResponseBody
    public ResultData doIncreaseHitCountRd(int id) {

        // 조회수를 증가시키고 결과를 가져옴
        ResultData increaseHitCountRd = articleService.increaseHitCount(id);

        // 실패 시 실패 결과 반환
        if (increaseHitCountRd.isFail()) {
            return increaseHitCountRd;
        }

        // 성공 시 새로운 데이터와 함께 성공 결과 반환
        ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", articleService.getArticleHitCount(id));
        rd.setData2("id", id);

        return rd;
    }

    // 게시글 작성 페이지를 보여주는 메서드
    @RequestMapping("/usr/article/write")
    public String showJoin(HttpServletRequest req) {
        return "usr/article/write";
    }

    // 게시글 작성 처리 메서드
    @RequestMapping("/usr/article/doWrite")
    @ResponseBody
    public String doWrite(HttpServletRequest req, int boardId, String title, String body) {
        Rq rq = (Rq) req.getAttribute("rq");

        // 제목이나 내용이 비어있을 경우 에러 메시지 반환
        if (Ut.isNullOrEmpty(title)) {
            return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
        }
        if (Ut.isNullOrEmpty(body)) {
            return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
        }

        // 게시글 작성 처리
        ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);

        // 작성한 게시글의 ID를 가져옴
        int id = (int) writeArticleRd.getData1();

        // 작성한 게시글 정보를 가져옴
        Article article = articleService.getArticle(id);

        // 작성 완료 후 상세 페이지로 리다이렉트
        return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + id);
    }

    // 게시글 수정 페이지를 보여주는 메서드
    @RequestMapping("/usr/article/modify")
    public String showModify(HttpServletRequest req, Model model, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        // 게시글 정보를 가져옴
        Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

        // 게시글이 존재하지 않을 경우 에러 메시지 반환
        if (article == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
        }

        // 모델에 게시글 정보 추가
        model.addAttribute("article", article);

        // 뷰 이름 반환
        return "usr/article/modify";
    }

    // 게시글 수정 처리 메서드
    @RequestMapping("/usr/article/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req, int id, String title, String body) {
        Rq rq = (Rq) req.getAttribute("rq");

        // 게시글 정보를 가져옴
        Article article = articleService.getArticle(id);

        // 게시글이 존재하지 않을 경우 에러 메시지 반환
        if (article == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
        }

        // 사용자가 수정할 권한이 있는지 확인
        ResultData loginedMemberCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

        // 권한이 있을 경우 게시글 수정
        if (loginedMemberCanModifyRd.isSuccess()) {
            articleService.modifyArticle(id, title, body);
        }

        // 수정 완료 후 상세 페이지로 리다이렉트
        return Ut.jsReplace(loginedMemberCanModifyRd.getResultCode(), loginedMemberCanModifyRd.getMsg(), "../article/detail?id=" + id);
    }

    // 게시글 삭제 처리 메서드
    @RequestMapping("/usr/article/doDelete")
    @ResponseBody
    public String doDelete(HttpServletRequest req, int id) {
        Rq rq = (Rq) req.getAttribute("rq");

        // 게시글 정보를 가져옴
        Article article = articleService.getArticle(id);

        // 게시글이 존재하지 않을 경우 에러 메시지 반환
        if (article == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
        }

        // 사용자가 삭제할 권한이 있는지 확인
        ResultData loginedMemberCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

        // 권한이 있을 경우 게시글 삭제
        if (loginedMemberCanDeleteRd.isSuccess()) {
            articleService.deleteArticle(id);
        }

        // 삭제 완료 후 리스트 페이지로 리다이렉트
        return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), "../article/list");
    }
}
