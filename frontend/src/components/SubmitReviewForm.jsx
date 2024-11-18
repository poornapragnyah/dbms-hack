"use client"
import React, { useState } from "react";

const SubmitReviewForm = () => {
  const [formData, setFormData] = useState({
    paperId: "",
    reviewerId: "",
    score: "",
    feedback: "",
  });
  const [message, setMessage] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch("http://localhost:3001/submit-review", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      const result = await response.json();
      if (response.ok) {
        setMessage(result.message);
      } else {
        setMessage("Error: " + result.error);
      }
    } catch (error) {
      setMessage("Error: " + error.message);
    }
  };

  return (
    <div className="max-w-md mx-auto mt-10 p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-semibold text-gray-800 mb-4">Submit Review</h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label htmlFor="paperId" className="block text-gray-700 font-medium">
            Paper ID
          </label>
          <input
            type="text"
            id="paperId"
            name="paperId"
            value={formData.paperId}
            onChange={handleChange}
            className="w-full mt-2 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Enter Paper ID"
            required
          />
        </div>
        <div>
          <label htmlFor="reviewerId" className="block text-gray-700 font-medium">
            Reviewer ID
          </label>
          <input
            type="text"
            id="reviewerId"
            name="reviewerId"
            value={formData.reviewerId}
            onChange={handleChange}
            className="w-full mt-2 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Enter Reviewer ID"
            required
          />
        </div>
        <div>
          <label htmlFor="score" className="block text-gray-700 font-medium">
            Score
          </label>
          <input
            type="number"
            id="score"
            name="score"
            value={formData.score}
            onChange={handleChange}
            className="w-full mt-2 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Enter Score (e.g., 8.0)"
            required
          />
        </div>
        <div>
          <label htmlFor="feedback" className="block text-gray-700 font-medium">
            Feedback
          </label>
          <textarea
            id="feedback"
            name="feedback"
            value={formData.feedback}
            onChange={handleChange}
            className="w-full mt-2 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Provide detailed feedback about the paper"
            rows="4"
          ></textarea>
        </div>
        <button
          type="submit"
          className="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600"
        >
          Submit Review
        </button>
      </form>
      {message && (
        <p className="mt-4 text-center text-gray-700 font-medium">{message}</p>
      )}
    </div>
  );
};

export default SubmitReviewForm;
