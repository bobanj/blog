jQuery(document).ready(function($) {
    $('a.my_tipsy').tipsy({gravity:'s'});
    
    /*-----------------------------------------------------------
     COMMENTS
     -----------------------------------------------------------*/

    //Select comment input on focus
    var commentDefaultText = "Remember, your comment represents you. Let's add value. Some XHTML is welcomed (strong em blockquote code).";

    $("#new_comment_canvas input[type=text], #new_comment_canvas textarea").focus(function() {
        var defaultText = $(this).val();
        if (defaultText === "Name" || defaultText === "Email" || defaultText === "Website" || defaultText === commentDefaultText) {
            $(this).select();
        }
    });

    //Don't submit comment or preview comment when no comment is given
    $("#new_comment_canvas input[type=submit]").live('click', function (event) {
        if ($("#comment_content").val() === "" || $("#comment_content").length === 0 || $("#comment_content").val() === commentDefaultText) {
            event.preventDefault();
            return false;
        }
    });

    //Preview a comment
    $("#preview_comment_link").live('click', function (event) {
        if ($("#comment_content").val() === "" || $("#comment_content").length === 0 || $("#comment_content").val() === commentDefaultText) {
            event.preventDefault();
            return false;
        } else {
            $.post($(this).attr('href'), $("#new_comment").serialize(), null, "script");
            event.preventDefault();
            return false;
        }
    });

    $("#edit_comment_link").click(function (event) {
        event.preventDefault();
        $("#comment_preview_canvas").hide();
        $("#new_comment_canvas").show();
    });

    /*-----------------------------------------------------------
     WMD
     -----------------------------------------------------------*/

    if ($("#wmd-container textarea").length) {
        $("#wmd-container textarea").elastic();
    }

    /*-----------------------------------------------------------
     POST CREATE AND DRAFT EDIT
     -----------------------------------------------------------*/

    function editPost() {
        var title = $("#title-container input").val();
        $(".post h2 a").text(title);
        var url = "/1234-" + title.replace(/[^a-zA-Z0-9]+/g, "-").replace(/-{2,}/g, "-").replace(/^-|-$/g, "").toLowerCase();
        $("#title-container p").text(url);
    }

    $("#title-container").live("keyup paste focus", function() {
        editPost();
    });

    //Only need to load the title in the url preview for the edit draft page
    if ($(".draft-title-container").length) {
        editPost();
    }

    /*-----------------------------------------------------------
     HIGHLIGHT.JS
     -----------------------------------------------------------*/

    hljs.tabReplace = '    ';
    hljs.initHighlightingOnLoad();

    //Turn on code highlight for post and draft previews
    $("#wmd-preview").live('click', function() {
        $("pre code").each(function(i, e) {
            hljs.highlightBlock(e, '    ')
        });
    });

    /*-----------------------------------------------------------
     TAG CLOUD
     -----------------------------------------------------------*/

    $('#tag_cloud a').tagcloud({
        size: {
            start: 12,
            end: 22,
            unit: 'px'
        },
        color: {
            start: "#5a5656",
            end: "#c5c5c5"
        }
    });

    /*-----------------------------------------------------------
     TWITTER
     -----------------------------------------------------------*/

    $.twitter = {
        container: $('#tweets_container'),
        loading_image: $('#twitter_loading'),
        update_interval: 420000, //7 minutes
        clearTimeout: function() {
            if (this.timer_id) {
                clearTimeout(this.timer_id)
            }
        },
        autoUpdate: function() {
            var self = this;
            self.clearTimeout();
            self.timer_id = setTimeout(function() {
                self.initialize();
            }, self.update_interval);
        },
        initialize: function() {
            var self = this;
            self.clearTimeout();
            if ($('#tweets_container').size() > 0) {
                $.ajax({
                    type: 'post',
                    url: "/services/twitter",
                    data: {},
                    dataType: 'html',
                    ifModified: true,
                    beforeSend: function() {
                        self.container.hide('slow');
                        self.loading_image.show('fast');
                    },
                    success: function(data, status) {
                        if (status != 'notmodified') {
                            self.container.fadeOut(1200, function() {
                                $(this).html(data);
                                $(this).fadeIn(1200);
                            });
                        }
                        self.loading_image.hide('fast');
                        self.autoUpdate();
                    },
                    error: function() {
                        self.loading_image.hide('fast');
                        self.autoUpdate();
                    }
                });
            }
        }
    };
    $.twitter.initialize();
}); //document.ready