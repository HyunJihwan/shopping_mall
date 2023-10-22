<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h3>카테고리</h3>


<style>
  /* 초기에 하위 항목 숨기기 */
  .low {
    display: none;
    z-index: 1;
  }

  ul {
    list-style: none;
    padding: 0;
  }

  ul li {
    margin: 0;
    padding: 0;
  }

  ul li a {
    text-decoration: none;
    color: #333;
  }

  /* 부모 항목에 마우스를 올리면 하위 항목 표시 */
  ul li:hover .low {
    display: block;
    position: absolute;
    background-color: #fff;
    border: 1px solid #ccc;
  }

  /* 스타일을 원하는대로 조정하세요. */
</style>


<script>
    const lowItems = document.querySelectorAll('.low li a');
    lowItems.forEach(item => {
        item.addEventListener('click', function(event) {
        	event.preventDefault();
        });
    });
</script>




<ul>
	<li><a href="/shop/list?c=100&l=1" >무기</a>
		
		<ul class="low" >
			<li><a href="/shop/list?c=101&l=2">돌격소총</a></li>
			<li><a href="/shop/list?c=102&l=2">기관단총</a></li>
			<li><a href="/shop/list?c=103&l=2">경기관총</a></li>
			<li><a href="/shop/list?c=104&l=2">산탄총</a></li>
			<li><a href="/shop/list?c=105&l=2">지정사수소총</a></li>
			<li><a href="/shop/list?c=106&l=2">저격소총</a></li>
			<li><a href="/shop/list?c=107&l=2">기타</a></li>
		</ul>
	</li>
	<li><a href="/shop/list?c=200&l=1">탄약</a></li>
	<li><a href="/shop/list?c=300&l=1">방어구</a></li>
	<li><a href="/shop/list?c=400&l=1">회복제</a></li>
</ul>