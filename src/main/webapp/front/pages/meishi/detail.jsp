<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>






































<!-- 首页 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>首页</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <!-- 样式 -->
    <link rel="stylesheet" href="../../css/style.css"/>
    <!-- 主题（主要颜色设置） -->
    <link rel="stylesheet" href="../../css/theme.css"/>
    <!-- 通用的css -->
    <link rel="stylesheet" href="../../css/common.css"/>
</head>
<body>

<div id="app">
    <div class="data-detail">
        <div class="data-detail-breadcrumb">
					<span class="layui-breadcrumb">
						<a href="../home/home.jsp">首页</a>
						<a><cite>{{detail.meishiName}}</cite></a>
					</span>

            <!-- 收藏 -->
            <a onclick="addMeishiCollection()" href="javascript:void(0)">
                <i class="layui-icon" style="font-size: 20px;color: red;">&#xe67a;</i>点我收藏
            </a>

        </div>
        <div class="layui-row">
            <div class="layui-col-md5">
                <div class="layui-carousel" id="swiper">
                    <div carousel-item id="swiper-item">
                        <div v-for="(item,index) in swiperList" v-bind:key="index">
                            <img class="swiper-item" :src="item.img">
                        </div>
                    </div>
                </div>

            </div>
            <div class="layui-col-md7" style="padding-left: 20px;">
                <h1 class="title">{{detail.meishiName}}</h1>

                <div v-if="detail.meishiMoney" class="detail-item">
                    <span>美食价格：</span>
                    <span class="desc">
                                {{detail.meishiMoney}}
                            </span>
                </div>

                <div v-if="detail.kouweiTypes" class="detail-item">
                    <span>口味：</span>
                    <span class="desc">
                        {{detail.kouweiValue}}
                    </span>
                </div>

                <div v-if="detail.dianzhiTypes" class="detail-item">
                    <span>店址：</span>
                    <span class="desc">
                        {{detail.dianzhiValue}}
                    </span>
                </div>

                <div v-if="detail.meishiJieyue" class="detail-item">
                    <span>点击率：</span>
                    <span class="desc">
                        {{detail.meishiJieyue}}
                    </span>
                </div>

                <div class="detail-item">

                    <!--<button onclick="addMeishiqqqqqqqq()" type="button" class="layui-btn layui-btn-warm">
                        添加到购物车
                    </button>-->
                    <button @click="jump('../meishiOrder/add.jsp?id='+detail.id)" type="button" class="layui-btn btn-submit">
                        立即预定
                    </button>
                </div>

                <div class="detail-item" style="text-align: right;">
                </div>
            </div>
        </div>

        <div class="layui-row">
            <div class="layui-tab layui-tab-card">

                <ul class="layui-tab-title">

                    <li class="layui-this">详情</li>

                    <li>留言</li>
                </ul>

                <div class="layui-tab-content">

                    <div class="layui-tab-item layui-show">
                        <div v-html="myFilters(detail.meishiContent)"></div>
                    </div>

                    <div class="layui-tab-item">
                        <div class="message-container">
                            <form class="layui-form message-form" style="padding-right: 20px;border-bottom: 0;">
                                <div class="layui-form-item layui-form-text">
                                    <label class="layui-form-label">留言</label>
                                    <div class="layui-input-block">
                                        <textarea name="meishiLiuyanContent" id="meishiLiuyanContent" required lay-verify="required" placeholder="留言内容"
                                                  class="layui-textarea"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn btn-submit" lay-submit lay-filter="meishiLiuyanContent">立即提交</button>
                                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                    </div>
                                </div>
                            </form>
                            <div class="message-list">
                                <div class="message-item" v-for="(item,index) in meishiLiuyanDataList" v-bind:key="index">
                                    <div class="username-container">
                                        <img class="avator" :src="item.yonghuPhoto">
                                        <span class="username">用户：{{item.yonghuName}}</span>
                                    </div>
                                    <div class="content">
												<span class="message">
													留言:{{item.meishiLiuyanContent}}
												</span>
                                    </div>
                                    <div class="content">
												<span class="message" style="color: #AF874D">
													回复:{{item.replyContent}}
												</span>
                                    </div>
                                </div>
                            </div>
                            <div class="pager" id="meishiLiuyanPager"></div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>


<script src="../../layui/layui.js"></script>
<script src="../../js/vue.js"></script>
<!-- 组件配置信息 -->
<script src="../../js/config.js"></script>
<!-- 扩展插件配置信息 -->
<script src="../../modules/config.js"></script>
<!-- 工具方法 -->
<script src="../../js/utils.js"></script>

<script>
    Vue.prototype.myFilters= function (msg) {
        if(msg != null){
            debugger
            return msg.replace(/\n/g, "<br>");
        }else{
            return "";
        }
    };
    var vue = new Vue({
        el: '#app',
        data: {
            // 轮播图
            swiperList: [],
            // 数据详情
            detail: {
                id: 0
            },
            // 加入购物车数量
            buynumber: 1,
            // 当前详情页表
            detailTable: 'meishi',
            // 留言列表
            meishiLiuyanDataList: [],
        },
        //  清除定时器
        destroyed: function () {
            // 不知道具体作用
            // window.clearInterval(this.inter);
        },
        methods: {
            jump(url) {
                jump(url)
            }
        }
    })

    layui.use(['layer', 'form', 'element', 'carousel', 'http', 'jquery', 'laypage'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var form = layui.form;
        var carousel = layui.carousel;
        var http = layui.http;
        var jquery = layui.jquery;
        var laypage = layui.laypage;

        var limit = 10;

        // 设置数量
        jquery('#buynumber').val(vue.buynumber);

        // 数据ID
        var id = http.getParam('id');
        vue.detail.id = id;

        // 当前详情
        http.request(`${vue.detailTable}/detail/` + id, 'get', {}, function (res) {
            // 详情信息
            vue.detail = res.data;
            vue.detail.meishiJieyue = vue.detail.meishiJieyue+1
            http.requestJson(`${vue.detailTable}/update`, 'post', vue.detail, function (res) {
            })


           // 轮播图片
            vue.swiperList = vue.detail.meishiPhoto ? vue.detail.meishiPhoto.split(",") : [];
            var swiperItemHtml = '';
            for (let item of vue.swiperList) {
                swiperItemHtml +=
                        '<div>' +
                        '<img class="swiper-item" src="' + item + '">' +
                        '</div>';
            }
            jquery('#swiper-item').html(swiperItemHtml);
            // 轮播图
            carousel.render({
                elem: '#swiper',
                width: swiper.width, height: swiper.height,
                arrow: swiper.arrow,
                anim: swiper.anim,
                interval: swiper.interval,
                indicator: swiper.indicator
            });
        });


        // 获取留言
        http.request(`${vue.detailTable}Liuyan/list`, 'get', {
            page: 1,
            limit: limit,
            meishiId: vue.detail.id
        }, function (res) {
            vue.meishiLiuyanDataList = res.data.list;
            // 分页
            laypage.render({
                elem: 'meishiLiuyanPager',
                count: res.data.total,
                limit: limit,
                jump: function (obj, first) {
                    //首次不执行
                    if (!first) {
                        http.request(`${vue.detailTable}Liuyan/list`, 'get', {
                            page: obj.curr,
                            limit: obj.limit,
                            meishiId: vue.detail.id
                        }, function (res) {
                            vue.meishiLiuyanDataList = res.data.list
                        })
                    }
                }
            });
        });

        // 提交留言
        form.on('submit(meishiLiuyanContent)', function (data) {
            data.yonghuId = localStorage.getItem('userid');
            data.tableName = localStorage.getItem('userTable');
            data.meishiLiuyanContent =jquery("#meishiLiuyanContent").val();
            data.meishiId = vue.detail.id;
            http.requestJson(`${vue.detailTable}Liuyan/add`, 'post', data, function (res) {
                layer.msg('留言成功', {
                    time: 2000,
                    icon: 6
                }, function () {
                    window.location.reload();
                });
                return false
            });
            return false
        });


    });



    // 收藏
    function addMeishiCollection(){
        layui.http.requestJson(`${vue.detailTable}Collection/add`, 'post', {
            yonghuId : localStorage.getItem('userid'),
            meishiId : vue.detail.id,
            tableName : localStorage.getItem('userTable')
        }, function (res) {
            if(res.code==0){
                layer.msg('收藏成功', {
                    time: 2000,
                    icon: 6
                });
            }else{
                layer.msg(res.msg, {
                    time: 2000,
                    icon: 2
                });
            }
        });
    }

    // 添加
    /*function addMeishiqqqqqqqq(){
        layui.http.requestJson(`${vue.detailTable}Cart/add`, 'post', {
            yonghuId : localStorage.getItem('userid'),
            meishiId : vue.detail.id,
            aaaaaaaa : vue.aaaaaaaa
        }, function (res) {
            if(res.code==0){
                layer.msg('添加成功', {
                    time: 2000,
                    icon: 6
                });
            }else{
                layer.msg(res.msg, {
                    time: 2000,
                    icon: 2
                });
            }
        });
    }*/


</script>
</body>
</html>
