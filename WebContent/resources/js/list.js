console.log('list.js');

$(function() {
	let keywordValue = getSearchParam('keyword');
	let typeValue = getSearchParam('type');
	let category = $('.category').val();
	console.log(keywordValue);	
	console.log(typeValue);	
	
	// 검색
	$('.searchForm button').on('click', function() {
		let category = $('.searchForm').find('.category').val();
		console.log(category);
		$('.searchForm').attr("action", `${contextPath}/game/list/${category}`).submit();
	});
	
	// 페이지 이동
	$('.pagination a').on('click', function(e) {
		e.preventDefault();
		console.log("카테" + category);
		let pageForm = $('<form>');
		pageForm.empty();
		pageForm.attr({
			'method' : 'get',
			'action' : `${contextPath}/game/list/${category}`
		}).append(getInputHiddenTag('page', $(this).attr('href')))
		if(typeValue != null && keywordValue != null) {
			pageForm.append(getInputHiddenTag('type', typeValue))
			.append(getInputHiddenTag('keyword', keywordValue))
		}
		pageForm.appendTo('body').submit();
	});
	
	$('.goDetail').on('click', function(e) {
		e.preventDefault();
		let goDetailForm = $('<form>');
		goDetailForm.empty();
		goDetailForm.attr({
			'method' : 'get',
			'action' : `${contextPath}/game/detail`
		}).append(getInputHiddenTag('bno', $(this).attr('href')))
		.append($('.page'))
		if(typeValue != null && keywordValue != null) {
			goDetailForm.append(getInputHiddenTag('type', typeValue))
			.append(getInputHiddenTag('keyword', keywordValue))
		}
		goDetailForm.appendTo('body').submit();
	})
	
});